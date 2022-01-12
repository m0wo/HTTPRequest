//
//  StravaSession.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation
import HTTPRequest
import Alamofire

/// Token session for the Strava API
struct StravaSession {

    /// Shared singleton `StravaSession` instance
    static var shared = StravaSession()

    /// Saved `Token`
    private(set) var token: Token? {
        didSet {
            try? updateTokenFile()
            try? updateTokenRefreshFile()
        }
    }

    /// Check if the saved `Token` is expired. If so, reset the token
    mutating func checkTokenExpiry() {
        guard let token = token else { return }
        if Self.shouldRefreshToken(token) {
            self.token = nil
        }
    }

    /// `Token` has expired or will expire
    /// Specially access token for the user is expired or will expire in one hour
    /// (3,600 seconds) or less
    static func shouldRefreshToken(_ token: Token) -> Bool {
        return token.expiresAt.epochDate < Date().addingTimeInterval(60)
    }

    /// Write or delete `TokenFile` based on the `token` property
    private func updateTokenFile() throws {
        if let token = token {
            try TokenFile.write(token)
        } else {
            try TokenFile.remove()
        }
    }

    /// Write the `TokenRefreshFile` based on the `token` property
    private func updateTokenRefreshFile() throws {
        guard let token = token else { return /* do nothing */ }
        var tokenRefresh = try TokenRefreshFile.read()
        tokenRefresh.refreshToken = token.refreshToken
        try TokenRefreshFile.write(tokenRefresh)
    }

    // MARK: - Init

    /// Initializer
    init() {
        token = try? TokenFile.read()
    }

    // MARK: - Sync

    /// Configure an active `StravaSession`
    ///
    /// - Parameter code: `String` code obtained in the redirect in OAuth flow
    mutating func configure(code: String? = nil) throws {
        // Expire old token
        checkTokenExpiry()

        // Return here if we already have a valid token
        guard token == nil else { return }

        // Fetch token from server
        let result: Result<Token, Error>
        if let code = code {
            // Fetch authorization token with the server
            result = try StravaAPI.authorizationToken(code: code).requestSync().modelResult()
        } else {
            // Refresh the token with the server
            result = try StravaAPI.refreshToken.requestSync().modelResult()
        }

        // Check the token was refreshed
        switch result {
        case .success(let token):
            self.token = token
        case .failure(let error):
            self.token = nil
            throw error
        }
    }
}
