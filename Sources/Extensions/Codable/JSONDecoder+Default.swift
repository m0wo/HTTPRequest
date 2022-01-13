//
//  JSONDecoder+Default.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation

public extension JSONDecoder {

    /// Default `JSONDecoder`
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.hierarchical)
        return decoder
    }

    /// Use snake_case when decoding from JSON data
    static var snakeCase: JSONDecoder {
        let decoder = JSONDecoder.default
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
