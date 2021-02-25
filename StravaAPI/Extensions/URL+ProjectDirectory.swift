//
//  URL+ProjectDirectory.swift
//  StravaAPI
//
//  Created by Ben Shutt on 25/02/2021.
//

import Foundation

extension URL {

    /// `URL` of the Xcode project file for **this** project.
    /// This should be equivalent to `${PROJECT_DIR}` in the build settings
    static func projectDirectory() throws -> URL {
        var url = URL(fileURLWithPath: #file)
        while url.pathComponents.count > 1 {
            url.deleteLastPathComponent()
            let files = try FileManager.default.contentsOfDirectory(atPath: url.path)
            let hit = files.contains { $0.pathExtension == .xcodeProjectExtension }
            if hit {
                return url
            }
        }

        throw FileURLError.fileNotFound
    }
}

// MARK: - String + Extensions

private extension String {

    /// Extension for an Xcode project file
    static let xcodeProjectExtension = "xcodeproj"

    /// - Returns: `pathExtension` on the `NSString`
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
}
