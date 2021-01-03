//
//  URL+Readable.swift
//  WhiskAPI
//
//  Created by Ben Shutt on 03/01/2021.
//

import Foundation

// MARK: - URLError

/// `Error` in `URL`
enum URLError: Error {
    
    /// Failed to create `URL` from the given `String`
    case malformedURL(String)
}

// MARK: - URL + Readable

extension URL: Readable {
    
    /// Initialize by passing the given `String` `component` throwing a
    /// `URLError` on failure
    ///
    /// - Parameter component: `String` component
    init(component: String) throws {
        guard let url = URL(string: component) else {
            throw URLError.malformedURL(component)
        }
        
        self = url
    }
}
