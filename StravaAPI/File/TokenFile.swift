//
//  TokenFile.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

/// File for reading and writing `Token` model
struct TokenFile {
    
    /// Name of the `Token` file
    private static let filename = "StravaToken.json"
    
    /// `URL` of the `Token` file
    static func url() throws -> URL {
        return try FileManager.default.url(
            for: .desktopDirectory,
            appending: [filename]
        )
    }
    
    /// Read `Token` from file
    static func read() throws -> Token {
        return try Token(data: Data(contentsOf: url()))
    }
    
    /// Write `Token` to file
    static func write(token: Token) throws {
        try token.encode().write(to: url())
    }
    
    /// Delete the `Token` file
    static func remove() throws {
        try FileManager.default.removeItem(at: url())
    }
}
