//
//  HTTPRequestable.swift
//  StravaAPI
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation

/// An entity which defines a `HTTPRequest`
public protocol HTTPRequestable {
    
    /// Construct a `HTTPRequest`
    var httpRequest: HTTPRequest { get }
}
