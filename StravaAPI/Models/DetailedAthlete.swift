//
//  DetailedAthlete.swift
//  StravaAPI
//
//  Created by Ben Shutt on 01/10/2020.
//

import Foundation

/// A (detailed) Strava Athlete
struct Athlete: StravaModel {

    /// The unique identifier of the athlete
    var id: Int

    /// The athlete's user name.
    var username: String

    /// Resource state, indicates level of detail. Possible values:
    /// - 1 -> "meta"
    /// - 2 -> "summary"
    /// - 3 -> "detail"
    var resourceState: Int

    /// The athlete's first name.
    var firstname: String

    /// The athlete's last name.
    var lastname: String

    /// URL to a 62x62 pixel profile picture.
    var profileMedium: String?

    /// URL to a 124x124 pixel profile picture.
    var profile: String?

    /// The athlete's city.
    var city: String?

    /// The athlete's state or geographical region.
    var state: String?

    /// The athlete's country.
    var country: String?

    /// The athlete's sex. May take one of the following values: M, F
    var sex: String?

    /// Whether the athlete has any Summit subscription.
    var summit: Bool

    /// The time at which the athlete was created.
    var createdAt: Date

    /// The time at which the athlete was last updated.
    var updatedAt: Date?

    /// The athlete's follower count.
    var followerCount: Int?

    /// The athlete's friend count.
    var friendCount: Int?

    /// The athlete's preferred unit system. May take one of the following values:
    /// - feet
    /// - meters
    var measurementPreference: String?

    /// The athlete's FTP (Functional Threshold Power).
    var ftp: Int?

    /// The athlete's weight.
    var weight: Float?

    /// The athlete's clubs.
    // var clubs: SummaryClub

    /// The athlete's bikes.
    // var bikes: SummaryGear

    /// The athlete's shoes.
    // var shoes: SummaryGear
}
