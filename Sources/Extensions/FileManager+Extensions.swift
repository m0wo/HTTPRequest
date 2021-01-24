//
//  FileManager+Extensions.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation

public extension FileManager {

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
}
