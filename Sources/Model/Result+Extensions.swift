//
//  Result+Extensions.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 28/09/2020.
//

import Foundation

public extension Swift.Result {
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    var success: Success? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    var failure: Failure? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}

public extension Swift.Result where Failure == Error {
    
    /// Cast `self` error type to generic `Swift.Error`
    /// - Parameter result: Result with specific `Error` type for `Failure`
    init<E>(result: Swift.Result<Success, E>) where E: Error {
        switch result {
        case .success(let success):
            self = .success(success)
        case .failure(let error):
            self = .failure(error)
        }
    }
}
