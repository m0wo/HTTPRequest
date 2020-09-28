//
//  AuthorizationManager.swift
//  StravaAPI
//
//  Created by Ben Shutt on 28/09/2020.
//

import Foundation

final class AuthorizationManager {
    
    static let authorization: StravaAuthorization? = nil
    
    /// Load `authorization`
    static func load() throws {
        // Check current token
        // If invalid refresh
    }
    
}


enum FileError: Error {
    
    /// File not found at the given `URL`
    case fileNotFound(URL)
}

extension StravaAuthorization {
    
    private static let filename = "StravaAuthorization.json"
    
    /// Load `StravaAuthorization` from the standard file
    static func load() throws -> StravaAuthorization {
        let fm = FileManager.default
        
        // Current working directory for the current process
        let directoryPath = fm.currentDirectoryPath
        let directory = URL(fileURLWithPath: directoryPath)

        // URL of JSON file
        let fileURL = directory.appendingPathComponent(Self.filename)

        // `Data` of JSON file
        let data = try Data(contentsOf: fileURL)
        
        // Decode the JSON into entity
        return try Self.decode(data: data)
    }
}
