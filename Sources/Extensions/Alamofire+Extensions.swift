//
//  Alamofire+Extensions.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 24/09/2020.
//

import Foundation
import Alamofire

// MARK: - HTTPHeader

public extension HTTPHeader {

    /// `"Accept: application/json"`
    static var acceptJSON: HTTPHeader = .accept("application/json")
    
    /// `"Content-Type: application/json"`
    static var contentTypeJSON: HTTPHeader = .contentType("application/json")
}

// MARK: - AFDataResponse<Data>

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
