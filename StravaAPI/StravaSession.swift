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
            try? updateTokenRequestFile()
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
        return token.expiryDate < Date().addingTimeInterval(3600)
    }

    /// Write or delete `TokenFile` based on the `token` property
    private func updateTokenFile() throws {
        if let token = token {
            try TokenFile.write(token)
        } else {
            try TokenFile.remove()
        }
    }

    /// Write the `TokenRequestFile` based on the `token` property
    private func updateTokenRequestFile() throws {
        guard let token = token else { return /* do nothing */ }
        var tokenRequest = try TokenRequestFile.read()
        tokenRequest.refreshToken = token.refreshToken
        try TokenRequestFile.write(tokenRequest)
    }

    // MARK: - Init

    init() {
        token = try? TokenFile.read()
    }

    // MARK: - Sync

    /// Configure an active `StravaSession`
    mutating func configure() throws {
        // Expire old token
        checkTokenExpiry()

        // Return here if we already have a valid token
        guard token == nil else { return }

        // Refresh the token with the server
        let result: Result<Token, Error> = try StravaAPI.refreshToken.requestSync().modelResult()

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

// MARK: - Token + Expiry

extension Token {

    /// `Date` the `Token` expires
    var expiryDate: Date {
        let timeInterval = TimeInterval(expiresAt)
        return Date(timeIntervalSince1970: timeInterval)
    }
}
