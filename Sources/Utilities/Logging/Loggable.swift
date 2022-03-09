//
//  Loggable.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 09/03/2022.
//

import Foundation
import os

/// An entity with an `OSLog`
protocol Loggable {

    /// `OSLog` instance
    var logger: OSLog { get }
}

// MARK: - Loggable + Extensions

extension Loggable {

    /// Log `message` of `type`
    ///
    /// - Note:
    /// `os_log` is safe to call from any thread
    ///
    /// - Parameters:
    ///   - type: `OSLogType`
    ///   - message: `String`
    func log(type: OSLogType, message: String) {
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
