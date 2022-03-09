//
//  Logger.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 09/03/2022.
//

import Foundation
import os

/// Basic structure conforming to `Loggable`
public struct Logger: Loggable {

    /// `OSLog` instance
    public let logger: OSLog

    /// Initialize with `tag`
    ///
    /// - Parameters:
    ///   - tag: `String`
    public init(tag: String) {
        self.init(logger: OSLog(tag: tag))
    }

    /// Memberwise initializer
    ///
    /// - Parameters:
    ///   - logger: `OSLog`
    public init(logger: OSLog) {
        self.logger = logger
    }
}
