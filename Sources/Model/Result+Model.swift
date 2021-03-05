//
//  Result+Model.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

// MARK: - Result + Model

public extension Result where Success == Data {

    /// 1. Try and get the associated value if the result is a success otherwise throw
    /// 2. Convert that success into a `T` by decoding
    func modelOrThrow<T>() throws -> T where T: Model {
        return try T.decode(data: successOrThrow())
    }

    /// Convert `Result` with `Data` to a `Result` for a `Model`of  type `T`
    func modelResult<T>() -> ModelResult<T> where T: Model {
        return .init({ try modelOrThrow() })
    }

    /// Convert to `Result<T, Error>` where `T` is a `Model` and return
    /// the associated value if the result is a success, `nil` otherwise
    func model<T>() -> T? where T: Model {
        return modelResult().success
    }
}
