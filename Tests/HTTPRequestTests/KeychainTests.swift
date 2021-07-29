//
//  KeychainTests.swift
//  HTTPRequestTests
//
//  Created by Ben Shutt on 29/07/2021.
//

import Foundation
import XCTest
@testable import HTTPRequest

/// Test `KeychainToken`
///
/// - Note:
/// These tests require Keychain access
final class KeychainTests: XCTestCase {

    /// Test `String` token
    private let token: String = UUID().uuidString

    /// Test `KeychainToken`
    private let keychainToken = KeychainToken(
        keychainIdentifier: "keychain.token.test"
    )

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        try? deleteToken() // Mask error
    }

    override func tearDown() {
        super.tearDown()
        try? deleteToken() // Mask error
    }

    // MARK: - KeychainToken

    /// Delete the test keychain token
    private func deleteToken() throws {
        try keychainToken.deleteToken()
    }

    // MARK: - Tests

    /// Test reading a keychain token when it doesn't exist
    func test_noToken() throws {
        XCTAssertThrowsError(try keychainToken.readToken())
    }

    /// Test writing a keychain token and reading it
    func test_readWrite() throws {
        // Make sure there is no token
        try test_noToken()

        // Write a new token
        try keychainToken.writeOrUpdate(token)

        // Read token and check it is as expected
        let newToken = try keychainToken.readToken()
        XCTAssertEqual(newToken, token)
    }

    /// Test writing a keychain token and reading it
    func test_update() throws {
        // Read and write
        try test_readWrite()

        // Create a new token
        let token2 = UUID().uuidString
        XCTAssertNotEqual(token, token2)

        // Delete token
        try keychainToken.writeOrUpdate(token2)

        // Read token and check it is as expected
        let newToken = try keychainToken.readToken()
        XCTAssertEqual(newToken, token2)
    }

    /// Test writing a keychain token and reading it
    func test_delete() throws {
        // Read and write
        try test_readWrite()

        // Delete token
        try keychainToken.deleteToken()

        // Make sure there is no token
        try test_noToken()
    }
}
