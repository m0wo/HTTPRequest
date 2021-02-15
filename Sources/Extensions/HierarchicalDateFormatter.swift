//
//  HierarchicalDateFormatter.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation

/// `DateFormatter` that falls back on date formats in a hierarchical manner.
/// A proxy `ISO8601` `DateFormatter`.
public class HierarchicalDateFormatter: DateFormatter {

    /// Override `dateFormat` default
    override public init() {
        super.init()
        dateFormat = DateFormatter.iso8601.dateFormat
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Override converting `String` to `Date` by falling back on a selection
    /// of standard date formats
    ///
    /// - Parameter string: `String`
    override public func date(from string: String) -> Date? {
        // Starting at the front, attempt the date formats
        // in order, falling back onto the next
        let dateFormats = [
            .iso8601Millis,

            // No milliseconds
            .iso8601,

            // No timeZone
            "yyyy-MM-dd'T'HH:mm:ss.SSS",

            // No milliseconds and no timeZone
            "yyyy-MM-dd'T'HH:mm:ss",

            // Date only
            "yyyy-MM-dd"
        ]

        for dateFormat in dateFormats {
            let formatter = DateFormatter.iso8601Formatter(
                dateFormat: dateFormat,
                timeZone: .current
            )
            if let date = formatter.date(from: string) {
                return date
            }
        }

        return nil
    }
}

// MARK: - DateFormatter + Hierarchical

public extension DateFormatter {

    /// `HierarchicalDateFormatter` converting a `String` to a `Date`
    /// by falling back on standard, common date formats
    static let hierarchical = HierarchicalDateFormatter()
}
