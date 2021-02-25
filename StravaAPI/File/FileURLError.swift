//
//  FileURLError.swift
//  StravaAPI
//
//  Created by Ben Shutt on 25/02/2021.
//

import Foundation

/// `Error` with a file `URL`
enum FileURLError: Error {

    /// Failed to find a file
    case fileNotFound

    /// Failed to find a file at the given `URL`
    case fileNotFoundAtURL(URL)
}
