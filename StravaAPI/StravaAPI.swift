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

// MARK: - HTTPHeader + Authorization

extension HTTPHeader {
    
    static var authorization: HTTPHeader? {
        let authorization = AuthorizationManager.authorization
        guard let token = authorization?.accessToken else { return nil }
        return .authorization(bearerToken: token)
    }
}

// MARK: - StravaAPI + HTTPRequestable

extension StravaAPI: HTTPRequestable {
    
    var httpRequest: HTTPRequest {
        switch self {
        
        case .refreshToken:
            return HTTPRequest(
                method: .post,
                urlComponents: .stravaAPI(endpoint: "oauth/token"),
                additionalHeaders: HTTPHeaders(headers: [
                    .acceptJSON,
                    .authorization
                ])
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

// MARK: - HTTPHeaders + Extensions

private extension HTTPHeaders {
    
    init(headers: [HTTPHeader?]) {
        self.init(headers.compactMap { $0 })
    }
}
