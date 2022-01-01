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

    /// Fetch logged in athlete activities
    case activities(ActivitiesRange)
}

// MARK: - StravaAPI + HTTPRequestable

extension StravaAPI: HTTPRequestable {

    func httpRequest() throws -> HTTPRequest {
        switch self {

        case .refreshToken:
            return try HTTPRequest(
                method: .post,
                urlComponents: .stravaAPI(
                    endpoint: "oauth/token",
                    queryItems: TokenRequestFile.read().queryItems()
                ),
                additionalHeaders: HTTPHeaders(headers: [
                    .acceptJSON
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

        case let .activities(range):
            return try HTTPRequest(
                method: .get,
                urlComponents: .stravaAPI(
                    endpoint: "athlete/activities",
                    queryItems: range.queryItems()
                ),
                additionalHeaders: HTTPHeaders(headers: [
                    .acceptJSON,
                    .authorization
                ])
            )
        }
    }
}
