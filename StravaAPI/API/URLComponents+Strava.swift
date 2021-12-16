//
//  URLComponents+Strava.swift
//  StravaAPI
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation
import Alamofire

extension URLComponents {

    /// Strava API for `endpoint` and `queryItems`
    ///
    /// - Parameters:
    ///   - endpoint: `String`
    ///   - queryItems: `[URLQueryItem]`
    static func stravaAPI(
        endpoint: String,
        queryItems: [URLQueryItem] = []
    ) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.strava.com"
        urlComponents.path = "/api/v3/\(endpoint)"
        urlComponents.queryItems = queryItems
        return urlComponents
    }
}

// MARK: - HTTPHeader + Authorization

extension HTTPHeader {

    /// Authorization bear `HTTPHeader`
    static var authorization: HTTPHeader? {
        let token = StravaSession.shared.token
        guard let accessToken = token?.accessToken else { return nil }
        return .authorization(bearerToken: accessToken)
    }
}
