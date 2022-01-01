//
//  Date+Extensions.swift
//  StravaAPI
//
//  Created by Ben Shutt on 01/01/2022.
//

import Foundation

extension Date {

    /// Using the `current` `Calendar`, add `days` days to `self`
    ///
    /// - Parameter days: `Int`
    /// - Returns: `Date?`
    func addingDays(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: self)
    }

    /// Execute `addingDays(_:)` throwing if `nil`
    ///
    /// - Parameter days: `Int`
    /// - Returns: `Date`
    func addingDaysOrThrow(_ days: Int) throws -> Date {
        guard let date = addingDays(days) else { throw DateError.nilCalendarDate }
        return date
    }
}

// MARK: - DateError

/// `Error` of `ActivitiesRange`
enum DateError: Error {

    /// `Date` was `nil` after a `Calendar` operation
    case nilCalendarDate
}
