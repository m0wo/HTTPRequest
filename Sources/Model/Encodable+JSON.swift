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
        let data = try encoder.encode(self)
        let encoding: String.Encoding = .utf8
        guard let json = String(data: data, encoding: encoding) else {
            throw StringDataError.data(data, encoding: encoding)
        }

        return json
    }
}
