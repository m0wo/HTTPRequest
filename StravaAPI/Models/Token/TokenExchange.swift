//
//  TokenExchange.swift
//  StravaAPI
//
//  Created by Ben Shutt on 12/01/2022.
//

import Foundation

/// Model to fetch an access token after being given the OAuth authorization code required to complete the authentication process
struct TokenExchange: Codable {

    /// The application’s ID, obtained during registration.
    var clientId: Int

    /// The application’s secret, obtained during registration.
    var clientSecret: String

    /// The code parameter obtained in the redirect.
    var code: String

    /// The grant type for the request. For initial authentication, must always be "authorization_code".
    var grantType = "authorization_code"

    /// Initialize with `code`
    ///
    /// - Parameter code: `String`
    init(code: String) throws {
        let tokenRefresh = try TokenRefreshFile.read()
        self.clientId = tokenRefresh.clientId
        self.clientSecret = tokenRefresh.clientSecret
        self.code = code
    }
}
