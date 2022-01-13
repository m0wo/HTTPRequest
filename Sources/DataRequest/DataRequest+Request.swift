//
//  DataRequest+Request.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation
import Alamofire

/// An `AFDataResponse` requesting `Data` from a `URL`
public typealias DataResponse = AFDataResponse<Data>

public extension DataRequest {

    /// Validate and execute request completing with `completion` on the given `queue`
    ///
    /// - Parameters:
    ///   - queue: `DispatchQueue`
    ///   - completion: `DataRequestCompletion`
    @discardableResult
    func execute(
        queue: DispatchQueue = .main,
        completion: @escaping (DataResponse) -> Void
    ) -> DataRequest {
        // Validate that the status codes are within the 200..<300 range,
        // and that the Content-Type header of the response matches
        // the Accept header of the request.
        // Then fetch the `Data`
        return validate().responseData(queue: queue) { response in
            // Log the response if the configuration flag is enabled
            HTTPRequest.log(type: .info, message: response.debugDescription)

            // Complete passing the response
            completion(response)

            // Post DataResponse on NotificationCenter
            NotificationCenter.default.post(
                dataRequest: self,
                dataResponse: response,
                object: self
            )
        }
    }
}
