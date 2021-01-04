//
//  AFDataResponse+Model.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation
import Alamofire

public extension AFDataResponse where Success == Data {

    /// `Result<T, Error>` where `T` is a `Model`
    func modelResult<T>() -> Result<T, Error> where T: Model {
        return result.modelResult()
    }

    /// Success of `Result<T, Error>` where `T` is a `Model`
    func model<T>() -> T? where T: Model {
        return result.model()
    }
}
