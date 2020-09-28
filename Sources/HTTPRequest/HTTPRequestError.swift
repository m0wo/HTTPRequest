//
//  HTTPRequestError.swift
//  StravaAPI
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation

/// An `Error` with `HTTPRequest`
public enum HTTPRequestError: Error {
    
    /// `HTTPRequest` threw an `Error` when being converted to a `URLRequest`
    case invalidRequest(HTTPRequest)
}
