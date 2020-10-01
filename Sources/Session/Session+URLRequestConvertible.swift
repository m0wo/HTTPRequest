//
//  Session+URLRequestConvertible.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation
import Alamofire

/// - TODO: Consider function conflicts with Alamofire (e.g. _: for URLRequest)
public extension Session {
    
    // MARK: - URLRequestConvertible
    
    /// Execute `request(urlRequest:queue:completion)` by converting
    /// `urlRequestConvertible` to a `URLRequest`
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
    
    /// Execute `requestModel(urlRequest:queue:completion)` by converting
    /// `urlRequestConvertible` to a `URLRequest`
    ///
    /// - Parameters:
    ///   - urlRequestConvertible: `URLRequestConvertible`
    ///   - queue: `DispatchQueue`
    ///   - completion: `DataRequestCompletion`
    @discardableResult
    func request<T>(
        _ urlRequestConvertible: URLRequestConvertible,
        queue: DispatchQueue = .main,
        completion: @escaping ResultCompletion<T>
    ) throws -> DataRequest where T: Model {
        let urlRequest = try urlRequestConvertible.asURLRequest()
        return request(
            urlRequest: urlRequest,
            queue: queue,
            completion: completion
        )
    }
    
    /// Execute `requestSync(urlRequest:)` by converting `urlRequestConvertible`
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
    
    /// Execute `requestModelSync(urlRequest:)` by converting
    /// `urlRequestConvertible` to a `URLRequest`
    ///
    /// - Parameters:
    ///   - urlRequestConvertible: `URLRequestConvertible`
    func requestSync<T>(
        _ urlRequestConvertible: URLRequestConvertible
    ) throws -> Result<T, Error> where T: Model {
        let urlRequest = try urlRequestConvertible.asURLRequest()
        return requestSync(urlRequest: urlRequest)
    }
}
