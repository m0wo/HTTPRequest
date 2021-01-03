//
//  TokenRequest.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

/// The request body when refreshing an access token.
/// On success, the server will send a `Token` response
struct TokenRequest: StravaModel {
    
    /// The application’s ID, obtained during registration.
    var clientId: Int
    
    /// The application’s secret, obtained during registration.
    /// (confidential)
    var clientSecret: String
    
    /// The grant type for the request.
    /// When refreshing an access token, must always be "refresh_token".
    var grantType: String
    
    /// The refresh token for this user, to be used to get the next access token for this user.
    /// Please expect that this value can change anytime you retrieve a new access token.
    /// Once a new refresh token code has been returned, the older code will no longer work.
    /// (confidential)
    var refreshToken: String
    
    // MARK: - Init
    
    init(
        clientId: Int,
        clientSecret: String,
        refreshToken: String
    ) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        grantType = "refresh_token"
        self.refreshToken = refreshToken
    }
}
