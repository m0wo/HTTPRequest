//
//  String+Extensions.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation

// MARK: - String + Prefix + Suffix

public extension String {
    
    /// Trim the `.whitespacesAndNewlines` `CharacterSet`
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Return `nil` if `isEmpty` otherwise return `self`
    var nilIfEmpty: String? {
        return isEmpty ? nil : self
    }
    
    /// If `self` does not have suffix: `suffix` then add suffix with `suffix`
    ///
    /// - Parameter suffix: `String`
    func suffixingIfRequired(_ suffix: String) -> String {
        guard !hasSuffix(suffix) else { return self }
        return self + suffix
    }
    
    /// If `self` does not have prefix: `prefix` then add prefix with `prefix`
    ///
    /// - Parameter prefix: `String`
    func prefixingIfRequired(_ prefix: String) -> String {
        guard !hasPrefix(prefix) else { return self }
        return prefix + self
    }
}
