//
//  APISuccess.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation

/// Wrapper of a `DataResponse` when an API succeeds
public struct APISuccess {

    /// `DataResponse`
    public let response: DataResponse

    /// `Data` returned from API
    public let data: Data

    /// Default initializer
    ///
    /// - Parameters:
    ///   - response: `DataResponse`
    ///   - data: `Data`
    public init(response: DataResponse, data: Data) {
        self.response = response
        self.data = data
    }
}
