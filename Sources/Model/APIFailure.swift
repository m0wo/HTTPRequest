//
//  APIFailure.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation

/// Wrapper of a `DataResponse` when an API fails
public struct APIFailure: Error {

    /// `DataResponse` (if a request was made)
    ///
    /// - Note:
    /// It would be nice to make this non-optional.
    /// It's optional because the app might throw while *creating* a request.
    /// For example, an encoding error when constructing a JSON body.
    /// In which case, the request itself was never made so there was no response.
    public let response: DataResponse?

    /// `Error` failure
    public let error: Error

    /// Default initializer
    ///
    /// - Parameters:
    ///   - response: `DataResponse?`
    ///   - failure: `Error`
    public init(response: DataResponse?, error: Error) {
        self.response = response
        self.error = error
    }

    // MARK: - Wrap

    /// Wrap `error` into a`APIFailure` if it is not already
    ///
    /// - Parameter error: `Error`
    public static func wrap(_ error: Error) -> APIFailure {
        return (error as? APIFailure) ?? APIFailure(response: nil, error: error)
    }
}
