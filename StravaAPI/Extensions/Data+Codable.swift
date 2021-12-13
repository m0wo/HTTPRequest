//
//  Data+Codable.swift
//  StravaAPI
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation
import HTTPRequest

// MARK: - Data + Decode

extension Data {

    /// Decode this JSON `Data` into `T` with `jsonDecoder`. Otherwise throw.
    ///
    /// - Parameter jsonDecoder: `JSONDecoder`
    func decode<T>(
        with jsonDecoder: JSONDecoder = .snakeCase
    ) throws -> T where T: Decodable {
        do {
            return try jsonDecoder.decode(T.self, from: self)
        } catch {
            Logger.log("[\(Self.self)] \(#function) \(error)")
            throw error
        }
    }
}

// MARK: - Encodable + Data

extension Encodable {

    /// Encode this instance into JSON `Data` with `jsonEncoder`. Otherwise throw.
    ///
    /// - Parameter jsonEncoder: `JSONEncoder`
    func encode(
        with jsonEncoder: JSONEncoder = .snakeCase
    ) throws -> Data {
        do {
            return try jsonEncoder.encode(self)
        } catch {
            Logger.log("[\(Self.self)] \(#function) \(error)")
            throw error
        }
    }
}

// MARK: - APIResult + Codable

extension APIResult {

    /// Decode success into `T` or throw
    func model<T: Codable>() throws -> T {
        return try successOrThrow().data.decode()
    }

    /// Map into model result of success type `T`
    func modelResult<T: Codable>() -> Result<T, Error> {
        return .init(catching: { try self.model() })
    }
}

// MARK: - JSONDecoder + SnakeCase

extension JSONDecoder {

    /// Use snake_case when decoding from JSON data
    static var snakeCase: JSONDecoder {
        let decoder = JSONDecoder.default
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

// MARK: - JSONEncoder + SnakeCase

extension JSONEncoder {

    /// Use snake_case when encoding to JSON data
    static var snakeCase: JSONEncoder {
        let encoder = JSONEncoder.default
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}
