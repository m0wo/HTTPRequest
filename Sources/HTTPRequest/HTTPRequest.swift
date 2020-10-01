//
//  HTTPRequest.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 24/09/2020.
//

import Foundation
import Alamofire

/// Structure of the components of a HTTP request
///
/// - Note:
/// This `struct` is effectively a wrapper of a `URLRequest` using `Alamofire` models.
public struct HTTPRequest {
    
    /// `HTTPMethod` of the request
    var method: HTTPMethod
    
    /// `URLComponents`
    var urlComponents: URLComponents
    
    /// `HTTPHeaders`
    var headers: HTTPHeaders
    
    /// `Data` in the request body
    var body: Data?
    
    /// `TimeInterval` to wait for a response before the requst times out
    var timeoutInterval: TimeInterval = 45
    
    // MARK: - Init
    
    /// `HTTPRequest` initializer
    ///
    /// - Parameters:
    ///   - method: `HTTPMethod`
    ///   - urlComponents: `URLComponents`
    ///   - additionalHeaders: `HTTPHeaders`
    ///   - body: `Data`
    public init(
        method: HTTPMethod,
        urlComponents: URLComponents,
        additionalHeaders: HTTPHeaders = [],
        body: Data? = nil
    ) {
        self.method = method
        self.urlComponents = urlComponents
        self.body = body
        
        var headers: HTTPHeaders = .default
        additionalHeaders.forEach {
            headers.add($0)
        }
        self.headers = headers
    }
}

// MARK: - URLRequestConvertible

extension HTTPRequest: URLRequestConvertible {
    
    /// `URLRequest` from `StravaAPI`
    public func asURLRequest() throws -> URLRequest {
        // urlComponents
        var urlComponents = self.urlComponents
        urlComponents.scheme = .toHTTPScheme(urlComponents.scheme)
        
        // urlComponents queryItems, removed from local `urlComponents`
        // and added to the `urlRequest` with encoding
        let queryItems = urlComponents.queryItems ?? []
        urlComponents.queryItems = nil
        
        // Throw on malformed URL
        let url = try urlComponents.asURL()
        
        // Get `URLRequest`
        var urlRequest = try URLRequest(url: url, method: method)
        
        // Set headers
        urlRequest.headers = headers
        
        // timeout
        urlRequest.timeoutInterval = timeoutInterval
        
        // Set httpBody
        urlRequest.httpBody = body
        
        // Encode parameters (queryItems)
        if queryItems.count > 0 {
            urlRequest = try URLEncoding.queryString.encode(
                urlRequest,
                with: queryItems.parameters()
            )
        }
        
        return urlRequest
    }
}
