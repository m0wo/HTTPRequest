//
//  Reader.swift
//  WhiskAPI
//
//  Created by Ben Shutt on 03/01/2021.
//

import Foundation
import HTTPRequest

/// Identity function returning the input `element`
///
/// - Parameter element: `T` An (arbitary) element
private func identity<T>(_ element: T) -> T {
    return element
}

/// Read a file with `URL`s separated by `.whitespacesAndNewlines`
struct Reader {

    /// Read an `[T]` from the given `URL` mapping each `String` component
    /// separated by `characterSet` using the `Readable` protocol
    ///
    /// - Parameters:
    ///   - url: `URL` to synchronously read `Data` and parse into `String`
    ///   - characterSet: `CharacterSet` to separate `String` components
    ///   - encoding: `String.Encoding`
    ///   - transform: `compactMap` the `String` components before mapping to `T`
    ///
    /// - Throws: `Error`
    /// - Returns: `[T]` where `T` is `Readable`
    public static func read<T>(
        from url: URL,
        separatedBy characterSet: CharacterSet,
        encoding: String.Encoding = .utf8,
        transform: (String) throws -> String? = identity(_:)
    ) throws -> [T] where T: Readable {
        return try Data(contentsOf: url)
            .stringOrThrow(encoding: encoding)
            .components(separatedBy: characterSet)
            .compactMap(transform)
            .map { try T(component: $0) }
    }
}
