//
//  FileURLError.swift
//  StravaAPI
//
//  Created by Ben Shutt on 25/02/2021.
//

import Foundation

/// `Error` with a file `URL`
enum FileError: Error {

    /// Failed to find a file
    case fileNotFound

    /// Failed to find a file at the given `URL`
    case fileNotFoundAtURL(URL)
}

// MARK: - LocalizedError

extension FileError: LocalizedError {

    /// Return error description for each case
    ///
    /// - TODO: Localize
    public var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "fileNotFound: Failed to find file"
        case let .fileNotFoundAtURL(url):
            return "fileNotFoundAtURL: Failed to find file at URL: '\(url)'"
        }
    }
}
