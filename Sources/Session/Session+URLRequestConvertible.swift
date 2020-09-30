//
//  Session+URLRequestConvertible.swift
//  StravaAPI
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation
import Alamofire

public extension Session {
    
    // MARK: - URLRequestConvertible
    
    /// Execute `request(urlRequest:queue:completion)` by converting
    /// `requestable` to a `URLRequest`
    ///
    /// - Parameters:
    ///   - urlRequestConvertible: `URLRequestConvertible`
    ///   - queue: `DispatchQueue`
    ///   - completion: `DataRequestCompletion`
    @discardableResult
    func request(
        _ urlRequestConvertible: URLRequestConvertible,
        queue: DispatchQueue = .main,
        completion: @escaping DataRequestCompletion
    ) throws -> DataRequest {
        let urlRequest = try urlRequestConvertible.asURLRequest()
        return request(
            urlRequest: urlRequest,
            queue: queue,
            completion: completion
        )
    }
    
    /// Execute `requestSync(urlRequest:)` by converting `requestable`
    /// to a `URLRequest`
    ///
    /// - Parameters:
    ///   - urlRequestConvertible: `URLRequestConvertible`
    func requestSync(
        _ urlRequestConvertible: URLRequestConvertible
    ) throws -> DataResponse {
        let urlRequest = try urlRequestConvertible.asURLRequest()
        return requestSync(urlRequest: urlRequest)
    }
    
    // MARK: - URLRequestConvertible
    
    /// Execute `request(urlRequest:queue:completion)` by converting
    /// `requestable` to a `URLRequest`
    ///
    /// - Parameters:
    ///   - requestable: `T`
    ///   - queue: `DispatchQueue`
    ///   - completion: `DataRequestCompletion`
    @discardableResult
    func request<T>(
        _ requestable: T,
        queue: DispatchQueue = .main,
        completion: @escaping DataRequestCompletion
    ) throws -> DataRequest where T: HTTPRequestable {
        return try request(
            requestable.httpRequest(),
            queue: queue,
            completion: completion
        )
    }
    
    /// Execute `requestSync(urlRequest:)` by converting `requestable`
    /// to a `URLRequest`
    ///
    /// - Parameters:
    ///   - requestable: `T`
    func requestSync<T>(
        _ requestable: T
    ) throws -> DataResponse where T: HTTPRequestable {
        return try requestSync(requestable.httpRequest())
    }
}
