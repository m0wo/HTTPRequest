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
    init(jsonData: Data, decoder: JSONDecoder = .default) throws {
        self = try decoder.decode(Self.self, from: jsonData)
    }

    /// Create `Decodable` from `dictionary`.
    ///
    /// - Note:
    /// This is generally not required as JSON `Data` is used instead
    ///
    /// - Parameter dictionary: `[AnyHashable: Any]`
    init(dictionary: [AnyHashable: Any]) throws {
        let jsonData = try JSONSerialization.data(
            withJSONObject: dictionary,
            options: []
        )
        try self.init(jsonData: jsonData)
    }
}

// MARK: - Array + Decodable

extension Array where Element: Decodable {

    /// `Array` of `Element`s from the given `array` of `[AnyHashable: Any]`
    ///
    /// - Parameter dictionaryArray: `[[AnyHashable : Any]]`
    init(dictionaryArray: [[AnyHashable: Any]]) throws {
        self = try dictionaryArray.map { try Element(dictionary: $0) }
    }
}
