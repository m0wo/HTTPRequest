//
//  LoggingTests.swift
//  HTTPRequestTests
//
//  Created by Ben Shutt on 09/03/2022.
//

import Foundation
import XCTest
@testable import HTTPRequest

/// Test logging
final class LoggingTests: XCTestCase {

    /// Test `Logger`
    func test_logger() throws {
        let logger = Logger(tag: "\(LoggingTests.self)")
        logger.log(type: .info, message: "Test log")
    }

    /// Test `HTTPRequestLogger`
    func test_httpRequestLogger() throws {
        HTTPRequestLogger.logs = [.decode, .encode]
        HTTPRequestLogger.log(type: .info, message: "Test log 1")
        HTTPRequestLogger.log(type: .info, message: "Test log 2")
    }
}
