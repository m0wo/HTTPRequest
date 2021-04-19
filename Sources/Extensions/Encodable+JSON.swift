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

    /// Create JSON `Data` from `Encodable`
    ///
    /// - Parameter encoder: `JSONEncoder`
    func jsonData(encoder: JSONEncoder = .default) throws -> Data {
        return try encoder.encode(self)
    }

    /// Use `JSONEncoder` with `.prettyPrinted` on `self`
    ///
    /// - Parameter encoder: `JSONEncoder`
    func jsonString(encoder: JSONEncoder = .default) throws -> String {
        encoder.outputFormatting = .prettyPrinted
        let data = try jsonData(encoder: encoder)
        return try data.stringOrThrow(encoding: .utf8)
    }

    /// Convert `self` to a `[AnyHashable: Any]`
    func dictionary() throws -> [AnyHashable: Any] {
        let jsonData = try self.jsonData()
        let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
        guard let dictionary = json as? [AnyHashable: Any] else {
            throw EncodableError.dictionary
        }
        return dictionary
    }
}

// MARK: - Array + Encodable

extension Array where Element: Encodable {

    /// Map to `[[AnyHashable : Any]]`
    func dictionaryArray() throws -> [[AnyHashable: Any]] {
        return try map { try $0.dictionary() }
    }
}
