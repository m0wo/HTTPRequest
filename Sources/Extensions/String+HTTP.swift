//
//  String+HTTP.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation

// MARK: - String + HTTP Scheme

extension String {

    /// Comvert `scheme` to a HTTP scheme.
    /// Output will be in: `["http", "https"]`
    ///
    /// - Parameter scheme: `String`
    static func toHTTPScheme(_ scheme: String?) -> String {
        let https = "https"
        if let proto = scheme?.lowercased(), ["http", https].contains(proto) {
            return proto
        }
        return https
    }
}
