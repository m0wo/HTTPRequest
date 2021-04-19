//
//  AFDataResponse+Model.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation
import Alamofire

public extension AFDataResponse where Success == Data {

    /// `modelOrThrow()` of `result` where `T` is a `Model`
    func modelOrThrow<T>() throws -> T where T: Model {
        return try result.modelOrThrow()
    }

    /// `modelResult()` of `result` where `T` is a `Model`
    func modelResult<T>() -> ModelResult<T> where T: Model {
        return result.modelResult()
    }

    /// `model()` of `result` where `T` is a `Model`
    func model<T>() -> T? where T: Model {
        return result.model()
    }
}
