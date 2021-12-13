//
//  Result+Extensions.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 28/09/2020.
//

import Foundation

// MARK: - Result + Extensions

public extension Result {

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

    /// Returns the associated value if the result is a success, `throws`  associated
    /// value of failure otherwise.
    func successOrThrow() throws -> Success {
        switch self {
        case .success(let success): return success
        case .failure(let error): throw error
        }
    }
}
