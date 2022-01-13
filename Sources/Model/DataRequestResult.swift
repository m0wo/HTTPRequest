//
//  DataRequestResult.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation

/// `Result` of a `DataRequest` request where
/// - `Success` is `DataRequestSuccess`
/// - `Failure` is `DataRequestFailure`
public typealias DataRequestResult = Result<DataRequestSuccess, DataRequestFailure>

/// Completion with a `DataRequestResult`
public typealias DataRequestCompletion = (DataRequestResult) -> Void

// MARK: - DataRequestResult + DataResponse

public extension DataRequestResult {

    /// Initialize with `response`
    ///
    /// - Parameter response: `DataResponse`
    init(response: DataResponse) {
        switch response.result {
        case let .success(data):
            let success = DataRequestSuccess(response: response, data: data)
            self = .success(success)
        case let .failure(error):
            let failure = DataRequestFailure(response: response, error: error)
            self = .failure(failure)
        }
    }
}
