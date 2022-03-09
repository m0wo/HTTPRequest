//
//  OSLog+Logger.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation
import os // OSLog

public extension OSLog {

    /// Framework `OSLog` shared instance 
    static let httpRequestLogger = OSLog(
        subsystem: Bundle.main.bundleIdentifier ?? "\(HTTPRequest.self)",
        category: "\(HTTPRequest.self)"
    )
}
