//
//  HTTPRequestable+Request.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation
import Alamofire

/// Execute a HTTP request
public extension HTTPRequestable {

    /// Execute HTTP request calling back with `completion` on the given `queue`
    ///
    /// - Parameters:
    ///   - queue: `DispatchQueue`
    ///   - completion: `APICompletion`
    ///
    /// - Returns: `DataRequest`
    @discardableResult
    func request(
        queue: DispatchQueue = .main,
        completion: @escaping APICompletion
    ) -> DataRequest? {
        do {
            // Try construct a URLRequest
            let urlRequest = try httpRequest().asURLRequest()

            // Create the (data) request
            let request = AF.request(urlRequest)

            // Execute the request and complete with the response
            request.execute(queue: queue) { response in
                completion(APIResult(response: response))
            }

            // Return request that was made
            return request
        } catch {
            // Construction of URLRequest threw an error.
            // Push completion to back of queue
            queue.async {
                completion(.failure(.wrap(error)))
            }

            // No request was made
            return nil
        }
    }

    /// Execute `request(queue:completion:)` synchronously
    func requestSync() throws -> APIResult {
        // Result from the API
        var result: APIResult!

        // Enter a group to wait on
        let group = DispatchGroup()
        group.enter()

        // Execute API asynchronously
        request(queue: .new) { newResult in
            // Set API result
            result = newResult

            // Leave group
            group.leave()
        }

        // Wait for group to finish and complete with result
        group.wait()
        return result
    }
}
