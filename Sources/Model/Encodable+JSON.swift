//
//  Encodable+JSON.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation

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
}
