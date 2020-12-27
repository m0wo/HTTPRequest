//
//  URLComponents+Whisk.swift
//  WhiskAPI
//
//  Created by Ben Shutt on 26/12/2020.
//

import Foundation
import Alamofire

extension URLComponents {
    
    /// Whisk API for `endpoint` and `parameters`
    ///
    /// - Parameters:
    ///   - endpoint: `String`
    ///   - parameters: `[URLQueryItem]`
    static func whiskAPI(
        endpoint: String,
        parameters: [URLQueryItem] = []
    ) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.whisk.com"
        urlComponents.path = "\(endpoint)"
        
        // queryItems
        let queryItems = urlComponents.queryItems ?? []
        urlComponents.queryItems = queryItems + parameters
        
        return urlComponents
    }
}
