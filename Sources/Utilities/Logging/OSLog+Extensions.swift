//
//  OSLog+Extensions.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 09/03/2022.
//

import Foundation
import os

extension OSLog {

    /// Initialize with `tag`
    ///
    /// - Parameters:
    ///   - tag: `String`
    convenience init(tag: String) {
        self.init(
            subsystem: Bundle.main.bundleIdentifier ?? tag,
            category: tag
        )
    }
}
