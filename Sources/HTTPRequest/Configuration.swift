//
//  HTTPRequestConfiguration.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 24/09/2020.
//

import Foundation
import os

public extension HTTPRequest {

    /// Configuration flags when making a `HTTPRequest`
    final class Configuration {

        /// Shared `HTTPRequestConfiguration` instance
        public static let shared = Configuration()

        /// `DispatchQueue` for thread safety
        private let dispatchQueue = DispatchQueue(label: UUID().uuidString)

        /// Log the `DataResponse` when the response has been received
        private var _logging = false
        public var logging: Bool {
            get {
                var value = false
                dispatchQueue.sync {
                    value = _logging
                }
                return value
            }
            set {
                dispatchQueue.async {
                    self._logging = newValue
                }
            }
        }
    }

    /// Log `message` on `logger`
    ///
    /// - Parameters:
    ///   - logger: `OSLog`
    ///   - type: `OSLogType`
    ///   - message: `String`
    static func log(
        _ logger: OSLog = .httpRequestLogger,
        type: OSLogType,
        message: String
    ) {
        guard HTTPRequest.Configuration.shared.logging else { return }
        guard #available(iOS 12, OSX 10.14, *) else { return }
        os_log(type, log: logger, "%@", message)
    }
}
