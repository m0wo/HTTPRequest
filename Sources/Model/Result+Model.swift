//
//  Result+Model.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

// MARK: - Result + Model

public extension Result where Success == Data {

    /// Convert `Result` with `Data` to a `Result` for a `Model`of  type `T`
    func modelResult<T>() -> Result<T, Error> where T: Model {
        do {
            let model = try T(result: self)
            return .success(model)
        } catch {
            return .failure(error)
        }
    }

    /// Convert to `Result<T, Error>` where `T` is a `Model` and return
    /// the associated value if the result is a success otherwise throw
    func modelOrThrow<T>() throws -> T where T: Model {
        return try modelResult().successOrThrow()
    }

    /// Convert to `Result<T, Error>` where `T` is a `Model` and return
    /// the associated value if the result is a success, `nil` otherwise
    func model<T>() -> T? where T: Model {
        return modelResult().success
    }
}

// MARK: - Model + Result

extension Model {

    /// Initialize `Model` with the given `result`, throwing an `Error` if the
    /// `Model` can not be initialized
    ///
    /// - Parameter result: `Result<Data, E>`
    init<E>(result: Result<Data, E>) throws where E: Error {
        switch result {
        case .success(let data):
            try self.init(data: data)
        case .failure(let error):
            throw error
        }
    }
}
