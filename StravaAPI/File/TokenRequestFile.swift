//
//  TokenRequestFile.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

/// File for reading and writing `TokenRequest` model
struct TokenRequestFile {
    
    /// Name of the `TokenRequest` file
    private static let filename = "StravaTokenRequest.json"
    
    /// `URL` of the `TokenRequest` file
    static func url() throws -> URL {
        return try FileManager.default.url(
            for: .desktopDirectory,
            appending: [filename]
        )
    }
    
    /// Read `TokenRequest` from file
    static func read() throws -> TokenRequest {
        return try TokenRequest(data: Data(contentsOf: url()))
    }
    
    /// Write `TokenRequest` to file
    static func write(tokenRequest: TokenRequest) throws {
        try tokenRequest.encode().write(to: url())
    }
    
    /// Delete the `TokenRequest` file
    static func remove() throws {
        try FileManager.default.removeItem(at: url())
    }
}
