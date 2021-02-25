//
//  TokenFile.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

/// File for reading and writing `Token` model
struct TokenFile: ModelFile {
    typealias Entity = Token

    /// Directory to save the token to
    private static let directoryName = "StravaToken"

    /// Name of the `Token` file
    private static let fileName = "StravaToken.json"

    /// Setup token directory
    @discardableResult
    static func setupDirectory() throws -> URL {
        let projectDirectory: URL = try .projectDirectory()
        let dir = projectDirectory.appendingPathComponent(directoryName)
        try FileManager.default.createDirectoryIfNotExists(dir)
        return dir
    }

    // MARK: - ModelFile

    /// `URL` of the `Token` file
    static func url() throws -> URL {
        let dir = try setupDirectory()
        return dir.appendingPathComponent(fileName)
    }
}
