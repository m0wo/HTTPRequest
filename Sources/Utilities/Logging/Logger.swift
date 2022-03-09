//
//  Logger.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 09/03/2022.
//

import Foundation
import os

/// Structure conforming to `Loggable`
public struct Logger: Loggable {

    /// `OSLog` instance
    public let logger: OSLog

    /// Initialize with `tag`
    ///
    /// - Parameters:
    ///   - tag: `String`
    public init(tag: String) {
        logger = OSLog(tag: tag)
    }
}
