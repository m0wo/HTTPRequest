//
//  URLQueryItem+Parameters.swift
//  StravaAPI
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation
import Alamofire

// MARK: - Array<URLQueryItem> + Parameters

extension Array where Element == URLQueryItem {
    
    /// Convert `[URLQueryItem]` to `Parameters`
    ///
    /// - Parameter mapNil:
    /// If the value of the `URLQueryItem` is `nil` then map the value to `NSNull`
    func parameters(mapNil: Bool = false) -> Parameters {
        let keyValues = compactMap { queryItem -> (String, Any)? in
            var value: Any? = queryItem.value
            if mapNil, value == nil {
                value = NSNull()
            }
            
            guard let queryValue = value else { return nil }
            return (queryItem.name, queryValue)
        }
        
        return Dictionary(uniqueKeysWithValues: keyValues)
    }
}
