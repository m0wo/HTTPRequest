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
    let inputURL = try FileManager.default.url(
        for: .desktopDirectory,
        appending: ["recipes.txt"]
    )
    
    // Read each component pruning lines which may not be valid URLs
    let recipes: [URL] = try Reader.read(
        from: inputURL,
        separatedBy: .whitespacesAndNewlines,
        transform: prune(urlString:)
    )
    
    // Convert to set to remove duplicates
    let recipesSet = Set(recipes)
    let string = recipesSet
        .map { $0.absoluteString }
        .joined(separator: "\n")
    
    let data = try string.dataOrThrow(encoding: .utf8)

    // `URL` in the `.desktopDirectory` to write to
    let outputURL = try FileManager.default.url(
        for: .desktopDirectory,
        appending: ["output-recipes.txt"]
    )

    try data.write(to: outputURL)
    
    debugPrint(recipes)
} catch {
    debugPrint(error)
}
