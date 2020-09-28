//
//  Alamofire+Extensions.swift
//  StravaAPI
//
//  Created by Ben Shutt on 24/09/2020.
//

import Foundation
import Alamofire

public extension HTTPHeader {

    /// `"Accept: application/json"`
    static var acceptJSON: HTTPHeader = .accept("application/json")
    
    /// `"Content-Type: application/json"`
    static var contentTypeJSON: HTTPHeader = .contentType("application/json")
}
