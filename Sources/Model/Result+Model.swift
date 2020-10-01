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
}

public extension Result where Success: Model {
    
    /// Get the `Success` or throw the `Failure` `Error`
    func modelOrThrow() throws -> Success {
        switch self {
        case .success(let model): return model
        case .failure(let error): throw error
        }
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
