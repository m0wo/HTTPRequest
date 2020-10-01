//
//  StravaAPI.swift
//  StravaAPI
//
//  Created by Ben Shutt on 24/09/2020.
//

import Foundation
import HTTPRequest
import Alamofire

/// Set of APIs to query for Strava
enum StravaAPI {
    
    /// Refresh an authorization token
    case refreshToken
    
    /// Fetch athlete based on authorization code (logged in)
    case athlete
}

// MARK: - StravaAPI + HTTPRequestable

extension StravaAPI: HTTPRequestable {
    
    func httpRequest() throws -> HTTPRequest {
        switch self {
        
        case .refreshToken:
            let tokenRequest = try TokenRequestFile.read()
            return HTTPRequest(
                method: .post,
                urlComponents: .stravaAPI(
                    endpoint: "oauth/token",
                    parameters: tokenRequest.queryItems
                ),
                additionalHeaders: HTTPHeaders(headers: [.acceptJSON])
            )
        
        case .athlete:
            return HTTPRequest(
                method: .get,
                urlComponents: .stravaAPI(endpoint: "athlete"),
                additionalHeaders: HTTPHeaders(headers: [
                    .acceptJSON,
                    .authorization
                ])
            )
        }
    }
}

// MARK: - TokenRequest + URLQueryItem

extension TokenRequest {
    
    /// - TODO: Compute from codeable?
    var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "client_id", value: "\(clientId)"),
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "grant_type", value: grantType),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
    }
}
