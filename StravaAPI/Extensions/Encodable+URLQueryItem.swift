//
//  Encodable+URLQueryItem.swift
//  StravaAPI
//
//  Created by Ben Shutt on 01/01/2022.
//

import Foundation
import HTTPRequest

extension Encodable {

    /// Map to `URLQueryItem`
    func queryItems() throws -> [URLQueryItem] {
        let dictionary = try dictionary(encoder: .snakeCase)
        guard let keyValues = dictionary as? [String: Any] else {
            throw DictionaryError.invalidKeyType
        }
        return keyValues.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
    }
}

// MARK: - DictionaryError

/// `Error` with `Dictionary`
enum DictionaryError: Error {

    /// Invalid key type
    case invalidKeyType
}
