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
    func requestModel<T>(
        _ urlRequestConvertible: URLRequestConvertible,
        queue: DispatchQueue = .main,
        completion: @escaping ResultCompletion<T>
    ) throws -> DataRequest where T: Model {
        let urlRequest = try urlRequestConvertible.asURLRequest()
        return requestModel(
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
    func requestModelSync<T>(
        _ urlRequestConvertible: URLRequestConvertible
    ) throws -> Result<T, Error> where T: Model {
        let urlRequest = try urlRequestConvertible.asURLRequest()
        return requestModelSync(urlRequest: urlRequest)
    }
}
