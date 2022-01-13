//
//  HTTPHeader+Headers.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation
import Alamofire

public extension HTTPHeader {

    // MARK: - JSON

    /// `"Accept: application/json"`
    static var acceptJSON: HTTPHeader = .accept("application/json")

    /// `"Content-Type: application/json"`
    static var contentTypeJSON: HTTPHeader = .contentType("application/json")
}
