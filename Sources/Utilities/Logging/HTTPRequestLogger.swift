//
//  HTTPRequestLogger.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 07/03/2022.
//

import Foundation
import os

/// Encapsulate framework logging and configuration flags
public struct HTTPRequestLogger: Loggable {

    /// Types of log to turn on and off
    public enum Log: CaseIterable {

        /// Log data request responses
        case response

        /// Log decoding errors
        case decode

        /// Log encoding errors
        case encode

        /// Log warnings
        case warnings
    }

    // MARK: - Static

    /// Shared singleton instance
    private static let shared = HTTPRequestLogger()

    /// Shorthand to get and set `Log`s which are enabled
    public static var logs: Set<Log> {
        get {
            return shared.logs.value
        }
        set {
            shared.logs.value = newValue
        }
    }

    /// Is the given `log` enabled
    ///
    /// - Parameters:
    ///   - log: `Log`
    /// - Returns: `Bool`
    public static func shouldLog(_ log: Log) -> Bool {
        return logs.contains(log)
    }

    /// Shorthand to log all cases of `Log`
    public static func logAll() {
        logs = Set(Log.allCases)
    }

    /// Alias to `log(type:message:)` of `shared`
    ///
    /// - Parameters:
    ///   - type: `OSLogType`
    ///   - message: `String`
    public static func log(type: OSLogType, message: String) {
        shared.log(type: type, message: message)
    }

    /// Alias to `log(error:)` of `shared`
    ///
    /// - Parameters:
    ///   - error: `Error`
    public static func log(error: Error) {
        shared.log(error: error)
    }

    // MARK: - Instance

    /// `OSLog` instance
    public let logger = OSLog(tag: "\(HTTPRequest.self)")

    /// The `Set` of `Log`s which are enabled
    ///
    /// By default, none are enabled
    private var logs = AtomicValue<Set<Log>>([])

    /// Initializer - lock override
    private init() {}
}
