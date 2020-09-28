//
//  URLComponents+Strava.swift
//  StravaAPI
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation

extension URLComponents {
    
    /// Strava API for `endpoint` and `parameters`
    ///
    /// - Parameters:
    ///   - endpoint: `String`
    ///   - parameters: `[URLQueryItem]`
    static func stravaAPI(
        endpoint: String,
        parameters: [URLQueryItem] = []
    ) -> URLComponents {
        var urlComponents: URLComponents = .stravaAPI
        
        // path
        urlComponents.path = urlComponents.path
            .suffixingIfRequired("/")
            .appending(endpoint)
        
        // queryItems
        let queryItems = urlComponents.queryItems ?? []
        urlComponents.queryItems = queryItems + parameters
        
        return urlComponents
    }
    
    /// `URLComponents` base for the Strava API
    static let stravaAPI: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.strava.com"
        urlComponents.path = "/api/v3"
        return urlComponents
    }()
}
