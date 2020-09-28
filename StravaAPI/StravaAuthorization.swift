//
//  StravaAuthorization.swift
//  StravaAPI
//
//  Created by Ben Shutt on 24/09/2020.
//

import Foundation
import HTTPRequest

/// Strava API credentials
struct StravaAuthorization: Model {
    
    /// Your application ID
    var clientId: Int
    
    /// Client secret (confidential)
    var clientSecret: String
    
    /// Authorization token which will change every six hours (confidential)
    var accessToken: String?
    
    /// The token you will use to get a new authorization token (confidential)
    var refreshToken: String

    // MARK: - StravaAuthorization + Model
    
    private enum CodingKeys: String, CodingKey {
        case clientId, clientSecret, refreshToken
    }
    
    static func decode(data: Data) throws -> StravaAuthorization {
        let decoder = JSONDecoder.default
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Self.self, from: data)
    }
    
    func encode() throws -> Data {
        let encoder = JSONEncoder.default
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(self)
    }
}
