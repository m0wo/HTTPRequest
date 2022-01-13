//
//  Encodable+JSON.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation

// MARK: - EncodableError

/// An `Error` with a `Encodable`
public enum EncodableError: Error {

    /// Could not convert `Encodable` to `[AnyHashable: Any]`
    case dictionary
}

// MARK: - Extensions

public extension Encodable {

    /// Use `JSONEncoder` to get JSON `Data` from `self` and map to `String`
    ///
    /// - Parameters:
    ///   - encoder: `JSONEncoder`
    ///   - encoding: `String.Encoding`
    ///
    /// - Returns: `String`
    func jsonString(
        encoder: JSONEncoder = .defaultPrettyPrinted,
        encoding: String.Encoding = .utf8
    ) throws -> String {
        return try encoder.encode(self).stringOrThrow(encoding: encoding)
    }

    /// Convert `self` to a `[AnyHashable: Any]`
    ///
    /// - Parameters:
    ///   - encoder: `JSONEncoder`
    func dictionary(encoder: JSONEncoder = .default) throws -> [AnyHashable: Any] {
        let data = try encoder.encode(self)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        guard let dictionary = json as? [AnyHashable: Any] else {
            throw EncodableError.dictionary
        }
        return dictionary
    }
}

// MARK: - Array + Encodable

extension Array where Element: Encodable {

    /// Map to `[[AnyHashable : Any]]`
    ///
    /// - Parameters:
    ///   - encoder: `JSONEncoder`
    func dictionaryArray(
        encoder: JSONEncoder = .default
    ) throws -> [[AnyHashable: Any]] {
        return try map { try $0.dictionary(encoder: encoder) }
    }
}
