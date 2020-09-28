//
//  Model.swift
//  BloodKit
//
//  Created by Ben Shutt on 02/03/2019.
//  Copyright © 2019 Moor. All rights reserved.
//

import Foundation
import OSLog
import Alamofire

// MARK: - Model

/// An `Error` with a `Model`
public enum ModelError: Error {
    
    /// Model failed to be validated
    case validation
    
    /// Could not convert `Model` to `[AnyHashable: Any]`
    case dictionary
}

/// An entity which conforms to `Codable`.
/// Typically an app "model" which gets decoded from a server response.
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

extension Model {
    
    /// By default take `Model` to be valid
    public var isValid: Bool {
        return true
    }
    
    /// By default use the `.default` `JSONDecoder`
    ///
    /// - Parameter data: `Data`
    public static func decode(data: Data) throws -> Self {
        return try JSONDecoder.default.decode(Self.self, from: data)
    }
    
    /// By default use the `.default` `JSONEncoder`
    public func encode() throws -> Data {
        return try JSONEncoder.default.encode(self)
    }
}

// MARK: - Model + CustomStringConvertible

extension Model {

    /// Take JSON `String` to describe the `Model`
    public var description: String {
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
            // Log the error before rethrowing
            os_log(.error, log: .logger, "%@", "\(error)")
            
            throw error
        }
    }
}

// MARK: - Model + Dictionary
    
public extension Model {
    
    /// `Model` from `dictionary`.
    ///
    /// - Note:
    /// This is generally not required as JSON `Data` is used instead
    ///
    /// - Parameter dictionary: `[AnyHashable: Any]`
    init (dictionary: [AnyHashable: Any]) throws {
        let jsonData = try JSONSerialization.data(
            withJSONObject: dictionary,
            options: []
        )
        try self.init(data: jsonData)
    }
    
    /// Convert `self` to `[AnyHashable: Any]`
    func dictionary() throws -> [AnyHashable: Any] {
        let jsonData = try self.jsonData()
        let json = try JSONSerialization.jsonObject(
            with: jsonData,
            options: []
        )
        guard let dictionary = json as? [AnyHashable : Any] else {
            throw ModelError.dictionary
        }
        return dictionary
    }
}

// MARK: - Array + Model

/// - TODO:  Use Collection for more generality?
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
    init (array: [[AnyHashable : Any]]) throws {
        self = try array.map {
            try Element(dictionary: $0)
        }
    }
}

extension Array: Model where Element: Model {
}

// MARK: - Result

public extension Swift.Result where Success == Data {
    
    /// Convert to `Result<T, Error>` for some `Model` type `T`
    func modelResult<T>() -> Swift.Result<T, Error> where T: Model {
        switch self {
        case .success(let data):
            do {
                let model = try T(data: data)
                return .success(model)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    /// Get `modelResult` and return `success` case
    func modelResultSuccess<T>() -> T? where T: Model {
        return modelResult().success
    }
}
