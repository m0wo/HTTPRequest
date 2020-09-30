//
//  StravaModel.swift
//  StravaAPI
//
//  Created by Ben Shutt on 30/09/2020.
//

import Foundation
import HTTPRequest

/// `Model` in which the default encoding and decoding from JSON uses
/// snake_case key names
protocol SnakeCaseModel: Model {
}

extension SnakeCaseModel {
    
    /// Use snake_case when decoding `Model` from JSON
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder.default
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Self.self, from: data)
    }
    
    /// Use snake_case when encoding `Model` to JSON
    func encode() throws -> Data {
        let encoder = JSONEncoder.default
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(self)
    }
}

/// A Strava `Model` is a `SnakeCaseModel`
typealias StravaModel = SnakeCaseModel
