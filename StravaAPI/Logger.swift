//
//  Logger.swift
//  StravaAPI
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation
import OSLog

extension OSLog {

    /// App `OSLog` shared instance
    static let logger = OSLog(
        subsystem: Bundle.main.bundleIdentifier ?? "\(Logger.self)",
        category: "\(Logger.self)"
    )
}

// MARK: - Logger

/// Utility structure for logging messages
struct Logger {

    /// Log `message` on `logger` of `type`
    ///
    /// - Parameters:
    ///   - message: `String`
    ///   - type: `OSLogType`
    ///   - logger: `OSLog`
    static func log(
        _ message: String,
        type: OSLogType = .info,
        logger: OSLog = .logger
    ) {
        os_log(type, log: logger, "%@", message)
    }

    /// Log `error` on `logger`
    ///
    /// - Parameters:
    ///   - error: `Error`
    ///   - logger: `OSLog`
    static func log(
        _ error: Error,
        logger: OSLog = .logger
    ) {
        log("\(error)", type: .error, logger: logger)
    }
}
