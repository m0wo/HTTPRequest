//
//  APIResult.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation

/// `Result` of a `API` request where
/// - `Success` is `APISuccess`
/// - `Failure` is `APIFailure`
public typealias APIResult = Result<APISuccess, APIFailure>

/// Completion with a `PacPointsAPIResult`
public typealias APICompletion = (APIResult) -> Void

// MARK: - APIResult + DataResponse

public extension APIResult {

    /// Initialize with `response`
    ///
    /// - Parameter response: `DataResponse`
    init(response: DataResponse) {
        switch response.result {
        case let .success(data):
            let success = APISuccess(response: response, data: data)
            self = .success(success)
        case let .failure(error):
            let failure = APIFailure(response: response, error: error)
            self = .failure(failure)
        }
    }
}
