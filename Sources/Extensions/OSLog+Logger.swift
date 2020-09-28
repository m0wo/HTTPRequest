//
//  OSLog+Logger.swift
//  StravaAPI
//
//  Created by Ben Shutt on 27/09/2020.
//

import Foundation
import OSLog

extension OSLog {
    
    /// Framework `OSLog` shared instance 
    static let logger = OSLog(
        subsystem: Bundle.main.bundleIdentifier ?? "\(HTTPRequest.self)",
        category: "\(HTTPRequest.self)"
    )
}
