//
//  TokenRequest+URLQueryItem.swift
//  StravaAPI
//
//  Created by Ben Shutt on 25/02/2021.
//

import Foundation

extension TokenRequest {

    /// Convert properties to `URLQueryItem` using reflection
    var queryItems: [URLQueryItem] {
        let mirror = Mirror(reflecting: self)
        return mirror.children.compactMap {
            guard let propertyName = $0.label else { return nil }
            let name = propertyName.camelCaseToSnakeCase()
            let value = "\($0.value)"
            return URLQueryItem(name: name, value: value)
        }
    }
}
