//
//  String+Extensions.swift
//  StravaAPI
//
//  Created by Ben Shutt on 25/02/2021.
//

import Foundation

extension String {

    /// Convert from `camelCase` to `snake_case`
    func camelCaseToSnakeCase() -> String {
        let acronymPattern = "([A-Z]+)([A-Z][a-z]|[0-9])"
        let normalPattern = "([a-z0-9])([A-Z])"
        let snakeCase = processCamelCaseRegex(pattern: acronymPattern)?
            .processCamelCaseRegex(pattern: normalPattern)
        return (snakeCase ?? self).lowercased()
    }

    /// Convert from `camelCase` to `snake_case` using the given `pattern`
    /// 
    /// - Parameter pattern: `String` regex
    private func processCamelCaseRegex(pattern: String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(
            in: self,
            options: [],
            range: range,
            withTemplate: "$1_$2"
        )
    }
}
