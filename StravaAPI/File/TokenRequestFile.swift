//
//  TokenRequestFile.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

/// File for reading and writing `TokenRequest` model
struct TokenRequestFile: ModelFile {
    typealias Entity = TokenRequest

    /// Name of the `TokenRequest` file
    private static let fileName = "StravaTokenRequest.json"

    // MARK: - ModelFile

    /// `URL` of the `TokenRequest` file
    static func url() throws -> URL {
        return try TokenFile.setupDirectory()
            .appendingPathComponent(fileName)
    }
}
