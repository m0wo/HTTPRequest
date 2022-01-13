//
//  TokenRefreshFile.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

/// File for reading and writing `TokenRefresh` model
struct TokenRefreshFile: ModelFile {
    typealias Entity = TokenRefresh

    /// Name of the `TokenRefresh` file
    private static let fileName = "\(TokenRefresh.self).json"

    // MARK: - ModelFile

    /// `URL` of the `TokenRefresh` file
    static func url() throws -> URL {
        return try TokenFile.setupDirectory()
            .appendingPathComponent(fileName)
    }
}
