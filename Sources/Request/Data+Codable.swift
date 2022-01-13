//
//  Data+Codable.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation

// MARK: - Data + Decodable

public extension Data {

    /// Decode this JSON `Data` into `T` with `jsonDecoder`. Otherwise throw.
    ///
    /// - Parameter jsonDecoder: `JSONDecoder`
    func decode<T>(with jsonDecoder: JSONDecoder) throws -> T where T: Decodable {
        do {
            return try jsonDecoder.decode(T.self, from: self)
        } catch {
            HTTPRequest.log(error: error)
            throw error
        }
    }
}

// MARK: - Encodable + Data

public extension Encodable {

    /// Encode this instance into JSON `Data` with `jsonEncoder`. Otherwise throw.
    ///
    /// - Parameter jsonEncoder: `JSONEncoder`
    func encode(with jsonEncoder: JSONEncoder) throws -> Data {
        do {
            return try jsonEncoder.encode(self)
        } catch {
            HTTPRequest.log(error: error)
            throw error
        }
    }
}
