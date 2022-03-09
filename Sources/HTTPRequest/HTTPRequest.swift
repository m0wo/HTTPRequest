//
//  HTTPRequest.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 24/09/2020.
//

import Foundation
import Alamofire

/// Structure of components required to build a HTTP request
///
/// - Note:
/// This `struct` is effectively a wrapper of a `URLRequest` using `Alamofire` models.
public struct HTTPRequest {

    /// `HTTPMethod` of the request
    public var method: HTTPMethod

    /// `URLComponents`
    public var urlComponents: URLComponents

    /// `HTTPHeaders`
    public var headers: HTTPHeaders

    /// `Data` in the request body
    public var body: Data?

    /// `TimeInterval` to wait for a response before the request times out
    public var timeoutInterval: TimeInterval = 45

    // MARK: - Init

    /// `HTTPRequest` initializer
    ///
    /// - Parameters:
    ///   - method: `HTTPMethod` to set as the HTTP method
    ///   - urlComponents: `URLComponents` to build a `URL` and `URLQueryItem`s
    ///   - additionalHeaders: `HTTPHeaders` to add to the `.default` headers
    ///   - body: `Data` HTTP body
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

    /// Map `HTTPRequest` to `URLRequest`
    public func asURLRequest() throws -> URLRequest {
        // urlComponents
        var urlComponents = self.urlComponents

        // Set nil or empty scheme if required
        let scheme = urlComponents.scheme ?? ""
        if scheme.isEmpty, Logger.shouldLog(.warnings) {
            Logger.shared.log(
                type: .debug,
                message: "Warning: nil scheme when mapping to \(URLRequest.self)"
            )
        }

        // Remove `queryItems` from the `urlComponents` and add to the
        // `urlRequest` with encoding
        let queryItems = urlComponents.queryItems ?? []
        urlComponents.queryItems = nil

        // Throw on malformed URL
        let url = try urlComponents.asURL()

        // Get `URLRequest`
        var urlRequest = try URLRequest(url: url, method: method)

        // Set headers
        urlRequest.headers = headers

        // Set timeoutInterval
        urlRequest.timeoutInterval = timeoutInterval

        // Set httpBody
        urlRequest.httpBody = body

        // Encode parameters i.e. the `queryItems`
        if !queryItems.isEmpty {
            urlRequest = try URLEncoding.queryString.encode(
                urlRequest,
                with: queryItems.parameters()
            )
        }

        return urlRequest
    }
}
