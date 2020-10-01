//
//  Session+URLRequest.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 24/09/2020.
//

import Foundation
import Alamofire
import OSLog

/// An `AFDataResponse` requesting `Data` from a `URL`
public typealias DataResponse = AFDataResponse<Data>

/// Completion block with a `DataResponse`
public typealias DataRequestCompletion = (DataResponse) -> Void

/// Completion block with a `Result<Success, Error>`
public typealias ResultCompletion<Success> = (Result<Success, Error>) -> Void

// MARK: - Session + `URLRequest`

public extension Session {
    
    /// Request `Data` for a given `urlRequest` completing with `completion`
    /// on the given `queue`
    ///
    /// - Parameters:
    ///   - urlRequest: `URLRequest`
    ///   - queue: `DispatchQueue`
    ///   - completion: `DataRequestCompletion`
    @discardableResult
    func request(
        urlRequest: URLRequest,
        queue: DispatchQueue = .main,
        completion: @escaping DataRequestCompletion
    ) -> DataRequest {
        return request(urlRequest)
        
            // Validate that the status codes are within the 200..<300 range,
            // and that the Content-Type header of the response matches
            // the Accept header of the request
            .validate()
            
            // Get `Data` response
            .responseData(queue: queue) { response in
                
                // Log the response if the configuration flag is enabled
                if HTTPRequest.Configuration.shared.responseLogging {
                    os_log(.info, log: .logger, "%@", response.debugDescription)
                }

                completion(response)
            }
    }
    
    /// Invoke `request(urlRequest:queue:completion:)`, on success, convert
    /// the response `Data` to an instance of `T` where `T` is a `Model`
    ///
    /// - Parameters:
    ///   - urlRequest: `URLRequest`
    ///   - queue: `DispatchQueue`
    ///   - completion: `ResultCompletion`
    @discardableResult
    func request<T>(
        urlRequest: URLRequest,
        queue: DispatchQueue = .main,
        completion: @escaping ResultCompletion<T>
    ) -> DataRequest where T: Model {
        return request(
            urlRequest: urlRequest,
            queue: queue
        ) { response in
            completion(response.result.modelResult())
        }
    }
        
    /// Request `Data` for a given `urlRequest` synchronously
    /// 
    /// - Parameters:
    ///   - urlRequest: `URLRequest`
    func requestSync(
        urlRequest: URLRequest
    ) -> DataResponse {
        let queue = DispatchQueue(label: UUID().uuidString)
        var dataResponse: DataResponse!
        
        let group = DispatchGroup()
        group.enter()
        request(urlRequest: urlRequest, queue: queue) { response in
            dataResponse = response
            group.leave()
        }
        group.wait()
        return dataResponse
    }
    
    /// Invoke `requestSync(urlRequest:)`, on success, convert
    /// the response `Data` to an instance of `T` where `T` is a `Model`
    ///
    /// - Parameter urlRequest: `URLRequest`
    func requestSync<T>(
        urlRequest: URLRequest
    ) -> Result<T, Error> where T: Model {
        return requestSync(urlRequest: urlRequest).result.modelResult()
    }
}
