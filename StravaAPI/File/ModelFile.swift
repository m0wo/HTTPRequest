//
//  ModelFile.swift
//  StravaAPI
//
//  Created by Ben Shutt on 25/02/2021.
//

import Foundation
import HTTPRequest

/// A file where a `Model` is written to and read from
protocol ModelFile {
    associatedtype Entity

    /// `URL` where the `Data` is located
    static func url() throws -> URL
}

// MARK: - Extensions

extension ModelFile where Entity: Codable {

    /// Read `Entity` from file
    static func read() throws -> Entity {
        return try Data(contentsOf: url()).decode(with: .snakeCase)
    }

    /// Write `Entity` to file
    static func write(_ entity: Entity) throws {
        try entity.encode(with: .snakeCase).write(to: url())
    }

    /// Delete the `Entity` file
    static func remove() throws {
        try FileManager.default.removeItem(at: url())
    }
}
