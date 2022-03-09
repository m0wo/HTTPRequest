//
//  Loggable.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 09/03/2022.
//

import Foundation
import os

/// Wrapper of an `OSLog` instance
public protocol Loggable {

    /// `OSLog`
    var logger: OSLog { get }
}

// MARK: - Extensions

public extension Loggable {

    /// Log `message` of `type`
    ///
    /// - Note:
    /// `os_log` is safe to call from any thread
    ///
    /// - Parameters:
    ///   - type: `OSLogType`
    ///   - message: `String`
    func log(type: OSLogType, message: String) {
        guard #available(iOS 12, OSX 10.14, *) else { return }
        os_log(type, log: logger, "%@", message)
    }

    /// Log `error`
    ///
    /// - Parameters:
    ///   - error: `Error`
    func log(error: Error) {
        log(type: .error, message: error.localizedDescription)
    }
}
