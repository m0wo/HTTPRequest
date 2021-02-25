//
//  Model.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 02/03/2019.
//  Copyright © 2019 Moor. All rights reserved.
//

import Foundation
import Alamofire
import os // OSLog

/// Shorthand for a `Result` where `Success = Model`, `Failure = Error`
public typealias ModelResult<Model> = Result<Model, Error>

// MARK: - Model

/// An `Error` with a `Model`
public enum ModelError: Error {

    /// `Model` validation failed.
    /// This comes from the `isValid` flag against the `Model`
    case validation
}

/// An entity which conforms to `Codable`.
/// Typically an app "model" which gets decoded from a server response.
///
/// - Note:
/// A JSON implementation is provided as a default.
public protocol Model: Codable, CustomStringConvertible {

    /// Validate the `Model` after being decoded from `Data`.
    /// E.g. Server might send an entity which is invalid in content
    var isValid: Bool { get }

    /// Decode the given `data` into `Self`
    /// `Data` is typically the response of a successful API.
    /// The default implementation uses the `.default` `JSONDecoder`.
    ///
    /// - Parameter data: `Data`
    static func decode(data: Data) throws -> Self

    /// Encode `self` into `Data`
    /// The default implementation uses the `.default` `JSONEncoder`.
    ///
    /// - Parameter data: `Data`
    func encode() throws -> Data
}

// MARK: - Model + Defaults

public extension Model {

    /// By default take `Model` to be valid
    var isValid: Bool {
        return true
    }

    /// By default use the `.default` `JSONDecoder`
    ///
    /// - Parameter data: `Data`
    static func decode(data: Data) throws -> Self {
        return try JSONDecoder.default.decode(Self.self, from: data)
    }

    /// By default use the `.default` `JSONEncoder`
    func encode() throws -> Data {
        return try JSONEncoder.default.encode(self)
    }
}

// MARK: - Model + CustomStringConvertible

public extension Model {

    /// Take JSON `String` to describe the `Model`
    var description: String {
        return (try? jsonString()) ?? String(describing: self)
    }
}

// MARK: - Model + Functionality

public extension Model {

    /// Create `Model` from given decodable `Data`
    ///
    /// - Parameter data: The `Data`
    init (data: Data) throws {
        do {
            // Read data
            let model = try Self.decode(data: data)

            // Validate the model is valid
            guard model.isValid else {
                throw ModelError.validation
            }

            self = model
        } catch {
            // Log the error before re-throwing
            os_log(.error, log: .logger, "%@", "\(error)")

            throw error
        }
    }
}

// MARK: - Array + Model

public extension Array where Element: Model {

    /// Create an `Array<Element>` where `Element` is a `Model`
    /// from decodable `Data`
    ///
    /// - Parameters:
    ///   - data: Decodable `Data`
    ///   - invalidHandler: Handle an invalid `Element`
    init (
        data: Data,
        invalidHandler: ((Element) throws -> Bool)? = nil
    ) throws {
        let array = try Self.decode(data: data)
        self = try array.filter { model in
            guard !model.isValid else { return true /* All good! */ }
            return (try invalidHandler?(model)) ?? false
        }
    }

    /// `Array` of `Model`s from the given `array`
    /// - Parameter array: `[[AnyHashable : Any]]`
    init (array: [[AnyHashable: Any]]) throws {
        self = try array.map {
            try Element(dictionary: $0)
        }
    }
}

extension Array: Model where Element: Model {
}
