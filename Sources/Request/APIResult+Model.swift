//
//  APIResult+Model.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation

// MARK: - APIResult + Codable

public extension APIResult {

    /// Decode success into `T` or throw
    ///
    /// - Parameters:
    ///   - decoder: `JSONDecoder`
    func model<T: Codable>(decoder: JSONDecoder) throws -> T {
        return try successOrThrow().data.decode(with: decoder)
    }

    /// Map into model result of success type `T`
    ///
    /// - Parameters:
    ///   - decoder: `JSONDecoder`
    func modelResult<T: Codable>(decoder: JSONDecoder) -> Result<T, Error> {
        return .init(catching: { try model(decoder: decoder) })
    }
}
