//
//  DataRequestSuccess.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation

/// Wrapper of a `DataResponse` when a data request succeeds
public struct DataRequestSuccess {

    /// `DataResponse`
    public let response: DataResponse

    /// `Data` returned from request
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
