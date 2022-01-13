//
//  Token.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

/// Model with a (short lived) access token
struct Token: Codable {

    /// The type of access token
    var tokenType: String

    /// The short-lived access token
    /// (confidential)
    var accessToken: String

    /// The number of seconds since the epoch when the provided access token will expire
    var expiresAt: Int

    /// Seconds until the short-lived access token will expire
    var expiresIn: Int

    /// The refresh token for this user, to be used to get the next access token for this user.
    /// Please expect that this value can change anytime you retrieve a new access token.
    /// Once a new refresh token code has been returned, the older code will no longer work.
    /// (confidential)
    var refreshToken: String
}
