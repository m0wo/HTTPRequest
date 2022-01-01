//
//  ActivitiesRange.swift
//  StravaAPI
//
//  Created by Ben Shutt on 01/01/2022.
//

import Foundation

/// Range to fetch activities
struct ActivitiesRange: Codable {

    /// An epoch timestamp to use for filtering activities that have taken place before a certain time.
    var before: Int

    /// An epoch timestamp to use for filtering activities that have taken place after a certain time.
    var after: Int

    /// Page number. Defaults to 1.
    var page: Int

    /// Number of items per page. Defaults to 30.
    var perPage: Int

    // MARK: - Init

    /// Initialize with `Date` objects
    ///
    /// - Parameters:
    ///   - from: `Date`
    ///   - to: `Date`
    ///   - page: `Int`
    ///   - perPage: `Int`
    init(
        from: Date,
        to: Date,
        page: Int = .page,
        perPage: Int = .perPage
    ) {
        self.before = Int(to.timeIntervalSince1970)
        self.after = Int(from.timeIntervalSince1970)
        self.page = page
        self.perPage = perPage
    }

    /// Initialize with default `from` and `to` `Date`s
    ///
    /// - Parameters:
    ///   - page: `Int`
    ///   - perPage: `Int`
    init(
        page: Int = .page,
        perPage: Int = .perPage
    ) throws {
        let from = try Date().addingDaysOrThrow(.fromDays)
        let to = Date()
        self.init(from: from, to: to, page: page, perPage: perPage)
    }
}

// MARK: - Int + Value

private extension Int {

    /// Default from days value
    static var fromDays: Int {
        return 7
    }

    /// Default page value
    static var page: Int {
        return 1
    }

    /// Default perPage value
    static var perPage: Int {
        return 30
    }
}
