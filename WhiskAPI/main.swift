//
//  main.swift
//  WhiskAPI
//
//  Created by Ben Shutt on 26/12/2020.
//

import Foundation
import HTTPRequest

/// Prune `urlString` trimming and only returning if it's a HTTP `URL`.
/// Otherwise it is inconsidered invalid and `nil` is returned.
///
/// - Parameter urlString: `String` form of the `URL`
func prune(urlString: String) -> String? {
    guard
        let string = urlString.trimmed.nilIfEmpty,
        string.starts(with: "http")
    else {
        return nil
    }

    return string
}

do {
    // `URL` of recipes in the `.desktopDirectory` to read `URL`s from
    let url = try FileManager.default.url(
        for: .desktopDirectory,
        appending: ["recipes.txt"]
    )
    
    // Read each component pruning lines which may not be valid URLs
    let recipes: [URL] = try Reader.read(
        from: url,
        separatedBy: .whitespacesAndNewlines,
        transform: prune(urlString:)
    )

    debugPrint(recipes)
} catch {
    debugPrint(error)
}

