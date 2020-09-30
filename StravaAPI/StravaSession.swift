//
//  StravaSession.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation
import HTTPRequest
import Alamofire

/// `Error`s with `StravaSession`
enum StravaSessionError: Error {
    
    /// Failed to refresh the `Token`
    case tokenRefreshFailed
}

/// Token session for the Strava API
struct StravaSession {
    
    /// Shared singleton `StravaSession` instance
    static var shared = StravaSession()
    
    /// Saved `Token`
    private(set) var token: Token? = nil {
        didSet {
            try? updateTokenFile()
        }
    }
    
    /// Check if the saved `Token` is expired. If so, reset the token
    mutating func checkTokenExpiry() {
        guard let token = token else { return }
        let hasExpired = token.expiryDate <= Date()
        if hasExpired {
            self.token = nil
        }
    }
    
    /// Write or delete `TokenFile` based on the `token` property
    private func updateTokenFile() throws {
        if let token = token {
            try TokenFile.write(token: token)
        } else {
            try TokenFile.remove()
        }
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
        let result: Result<Token, Error> = try AF.requestModelSync(
            urlRequest: StravaAPI.refreshToken.httpRequest().asURLRequest()
        )
        
        // Check the token was refreshed
        token = result.success
        if token == nil {
            throw StravaSessionError.tokenRefreshFailed
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
