//
//  StringDataTests.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 18/10/2020.
//

import Foundation
import XCTest
@testable import HTTPRequest

/// Test `String` to `Data` and vice versa
final class StringDataTests: XCTestCase {

    /// `String.Encoding` to use when converting a `String` to `Data` and vice versa
    private let encoding: String.Encoding = .utf8

    /// Test converting `String` to `Data`
    func test_stringToData() throws {
        // Create test `String`
        let testString = "Hello \(Self.self)"

        // Convert
        let data = try testString.dataOrThrow(encoding: encoding)
        let result = try data.stringOrThrow(encoding: encoding)

        // Assert `String`
        XCTAssertEqual(testString, result)

        // Convert to data again
        let data2 = try result.dataOrThrow(encoding: encoding)

        // Assert `Data`
        XCTAssertEqual(data, data2)
    }
}
