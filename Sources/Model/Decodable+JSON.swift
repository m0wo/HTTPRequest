//
//  Decodable+JSON.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation

public extension Decodable {

    /// Create `Decodable` from JSON `Data`.
    ///
    /// - Parameters:
    ///   - jsonData: JSON `Data`
    ///   - decoder: `JSONDecoder`
    init (jsonData: Data, decoder: JSONDecoder = .default) throws {
        self = try decoder.decode(Self.self, from: jsonData)
    }
}
