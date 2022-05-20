//
//  FileManager+Extensions.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

extension FileManager {

    /// Find a `URL` appending any `pathComponents`
    ///
    /// - Parameters:
    ///   - searchPathDirectory: `SearchPathDirectory`
    ///   - domainMask: `SearchPathDomainMask`
    ///   - appropriateForURL: `URL`
    ///   - create: `Bool`
    ///   - pathComponents: `[String]`
    func url(
        for searchPathDirectory: SearchPathDirectory,
        in domainMask: SearchPathDomainMask = .userDomainMask,
        appropriateFor appropriateForURL: URL? = nil,
        create: Bool = true,
        appending pathComponents: [String] = []
    ) throws -> URL {
        // Get `searchPathDirectory`
        var url = try self.url(
            for: searchPathDirectory,
            in: domainMask,
            appropriateFor: appropriateForURL,
            create: create
        )

        pathComponents.forEach {
            url.appendPathComponent($0)
        }

        return url
    }

    // MARK: - Directory

    /// File at `path` exists and is a directory
    ///
    /// - Parameter path: `String`
    func isDirectory(_ path: String) -> Bool {
        var bool: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &bool)
        return exists && bool.boolValue
    }

    /// File at `url` exists and is a directory
    ///
    /// - Parameter url: `URL`
    func isDirectory(_ url: URL) -> Bool {
        return isDirectory(url.path)
    }

    /// If `url` does not exist or is not a directory, create it.
    /// Throw `Error` on failure.
    ///
    /// - Parameters:
    ///   - url: `URL` for directory to create if required
    ///   - intermediate: `Bool` Create intermediate directories
    ///   - attributes: `[FileAttributeKey : Any]` attributes
    func createDirectoryIfNotExists(
        _ url: URL,
        withIntermediateDirectories intermediate: Bool = true,
        attributes: [FileAttributeKey: Any]? = nil
    ) throws {
        guard !isDirectory(url) else { return }
        try createDirectory(
            at: url,
            withIntermediateDirectories: intermediate,
            attributes: attributes
        )
    }
}
