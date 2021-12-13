//
//  JSONEncoder+Default.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 04/01/2021.
//

import Foundation

public extension JSONEncoder {

    /// Default `JSONEncoder`
    static var `default`: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.hierarchical)
        return encoder
    }

    /// Default `JSONEncoder` with pretty printed output
    static var defaultPrettyPrinted: JSONEncoder {
        let encoder: JSONEncoder = .default
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }
}
