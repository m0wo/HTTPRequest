//
//  Data+Codable.swift
//  StravaAPI
//
//  Created by Ben Shutt on 12/01/2022.
//

import Foundation
import HTTPRequest

// MARK: - Data + Decodable

extension Data {

    func decode<T: Decodable>() throws -> T {
        return try decode(with: .snakeCase)
    }
}

// MARK: - Encodable + Data

extension Encodable {

    func encode() throws -> Data {
        return try encode(with: .snakeCase)
    }
}
