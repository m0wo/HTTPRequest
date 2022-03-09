//
//  URL+Extensions.swift
//  StravaAPI
//
//  Created by Ben Shutt on 25/02/2021.
//

import Foundation

extension URL {

    /// Find root directory containing the `"Package.swift"` file
    ///
    /// - Returns: `URL`
    static func findRootDirectory() throws -> URL {
        var url = URL(fileURLWithPath: #file)
        while url.pathComponents.count > 1 {
            url.deleteLastPathComponent()
            let isHit = try url.containsFile(named: "Package.swift")
            if isHit {
                return url
            }
        }

        throw FileURLError.fileNotFound
    }

    /// Does this directory contain a file with the given `fileName`
    ///
    /// - Parameter fileName: `String`
    /// - Returns: `Bool`
    private func containsFile(named fileName: String) throws -> Bool {
        return try FileManager.default
            .contentsOfDirectory(atPath: path)
            .contains { $0 == fileName }
    }
}
