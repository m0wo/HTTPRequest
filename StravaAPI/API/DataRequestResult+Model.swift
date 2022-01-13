//
//  DataRequestResult+Model.swift
//  StravaAPI
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation
import HTTPRequest

extension DataRequestResult {

    /// Decode success into `T` or throw
    func model<T: Codable>() throws -> T {
        return try model(decoder: .snakeCase)
    }

    /// Map into model result of success type `T`
    func modelResult<T: Codable>() -> Result<T, Error> {
        return modelResult(decoder: .snakeCase)
    }
}
