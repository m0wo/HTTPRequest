//
//  HTTPHeaders+Extensions.swift
//  StravaAPI
//
//  Created by Ben Shutt on 01/10/2020.
//

import Foundation
import Alamofire

// MARK: - HTTPHeaders + Extensions

extension HTTPHeaders {

    /// Create with non-`nil` elements of `headers`
    /// 
    /// - Parameter headers: `[HTTPHeader?]`
    init (headers: [HTTPHeader?]) {
        self.init(headers.compactMap { $0 })
    }
}
