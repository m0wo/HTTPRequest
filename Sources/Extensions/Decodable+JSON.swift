//
//  Decodable+JSON.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation

public extension Decodable {

    /// Create `Decodable` from `dictionary`.
    ///
    /// - Note:
    /// This is generally not required as JSON `Data` is used instead
    ///
    /// - Parameters:
    ///   - decoder: `JSONDecoder`
    ///   - dictionary: `[AnyHashable: Any]`
    init(
        decoder: JSONDecoder = .default,
        dictionary: [AnyHashable: Any]
    ) throws {
        let data = try JSONSerialization.data(
            withJSONObject: dictionary,
            options: []
        )
        self = try decoder.decode(Self.self, from: data)
    }
}

// MARK: - Array + Decodable

extension Array where Element: Decodable {

    /// `Array` of `Element`s from the given `array` of `[AnyHashable: Any]`
    ///
    /// - Parameters:
    ///   - decoder: `JSONDecoder
    ///   - dictionaryArray: `[[AnyHashable : Any]]`
    init(
        decoder: JSONDecoder = .default,
        dictionaryArray: [[AnyHashable: Any]]
    ) throws {
        self = try dictionaryArray.map {
            try Element(decoder: decoder, dictionary: $0)
        }
    }
}
