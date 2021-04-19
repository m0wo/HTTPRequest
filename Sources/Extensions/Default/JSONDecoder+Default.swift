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
}
