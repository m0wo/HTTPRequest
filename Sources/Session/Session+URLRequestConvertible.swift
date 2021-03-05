//
//  Session+URLRequestConvertible.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation
import Alamofire

public extension Session {

    /// Execute `request(urlRequest:queue:completion)` by converting
    /// `urlRequestConvertible` to a `URLRequest`.
    /// If that conversion throws, execute the `completion` on the `queue` failing with
    /// the `Error` that was thrown.
    ///
    /// - Parameters:
    ///   - urlRequestConvertible: `URLRequestConvertible`
    ///   - queue: `DispatchQueue`
    ///   - completion: `ResultCompletion<Data>`
    @discardableResult
    func request(
        _ urlRequestConvertible: URLRequestConvertible,
        queue: DispatchQueue = .main,
        completion: @escaping ResultCompletion<Data>
    ) -> DataRequest? {
        do {
            let urlRequest = try urlRequestConvertible.asURLRequest()
            return request(
                urlRequest: urlRequest,
                queue: queue,
                completion: { response in
                    completion(response.result.generalErrorResult)
                }
            )
        } catch {
            queue.async {
                completion(.failure(error))
            }
            return nil
        }
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
}
