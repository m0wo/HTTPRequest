//
//  KeychainToken.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 11/12/2020.
//  Copyright © 2020 3 SIDED CUBE APP PRODUCTIONS LTD. All rights reserved.
//

import Foundation

/// Store a token (e.g. authentication) into the Keychain.
///
/// - Warning:
/// Make sure to consider keychain thread blocking when using this structure.
/// E.g. may need to wait for `applicationProtectedDataDidBecomeAvailable`
public struct KeychainToken {

    /// `String.Encoding` converting from `Data` to `String` and vice versa
    private static let encoding: String.Encoding = .utf8

    /// Value for key `kSecClass` in Keychain query
    private static let classKey: CFString = kSecClassKey

    /// Value for key `kSecAttrApplicationTag` in Keychain query
    public let keychainIdentifier: String

    /// `Data` of `keychainIdentifier` using `encoding`
    private func keychainIdentifierData() throws -> Data {
        return try keychainIdentifier.dataOrThrow(encoding: Self.encoding)
    }

    // MARK: - Init

    /// Initialize with `keychainIdentifier`
    ///
    /// - Parameter keychainIdentifier: `String`
    public init(keychainIdentifier: String) {
        self.keychainIdentifier = keychainIdentifier
    }

    // MARK: - Read

    /// Read token from Keychain
    public func readToken() throws -> String {
        // `CFDictionary` query to fetch
        let fetchQuery: [String: Any] = [
            kSecClass as String: Self.classKey,
            kSecAttrApplicationTag as String: try keychainIdentifierData(),
            kSecReturnData as String: true
        ]

        // Read from Keychain
        var dataTypeRef: AnyObject?
        let status = withUnsafeMutablePointer(to: &dataTypeRef) {
            SecItemCopyMatching(fetchQuery as CFDictionary, UnsafeMutablePointer($0))
        }

        // Assert successful status
        guard status == errSecSuccess else {
            throw KeychainError.invalidStatus(status)
        }

        // Assert data is valid
        guard let data = dataTypeRef as? Data else {
            throw KeychainError.invalidRef(dataTypeRef)
        }

        // Parse as `String`
        return try data.stringOrThrow(encoding: Self.encoding)
    }

    // MARK: - Write/Update

    /// Try `writeToken(_:)` falling back on `updateToken(_:)`
    ///
    /// - Parameter token: `String` token
    public func writeOrUpdate(_ token: String) throws {
        let oldValue = try? readToken() // Don't throw
        defer {
            postNotification(oldValue: oldValue)
        }

        do {
            try writeToken(token)
        } catch {
            try updateToken(token)
        }
    }

    /// Write token to Keychain
    ///
    /// - Parameter token: `String` token
    private func writeToken(_ token: String) throws {
        // Parse `token` as `Data
        let tokenData = try token.dataOrThrow(encoding: Self.encoding)

        // `CFDictionary` query to add
        let addQuery: [String: Any] = [
            kSecClass as String: Self.classKey,
            kSecAttrApplicationTag as String: try keychainIdentifierData(),
            kSecValueData as String: tokenData
        ]

        // Add to Keychain
        let status = SecItemAdd(addQuery as CFDictionary, nil)

        // Assert successful status
        guard status == errSecSuccess else {
            throw KeychainError.invalidStatus(status)
        }
    }

    /// Update token in Keychain
    ///
    /// - Parameter token: `String` token
    private func updateToken(_ token: String) throws {
        // Parse `token` as `Data
        let tokenData = try token.dataOrThrow(encoding: Self.encoding)

        // `CFDictionary` query to identify
        let updateQuery: [String: Any] = [
            kSecClass as String: Self.classKey,
            kSecAttrApplicationTag as String: try keychainIdentifierData()
        ]

        // `CFDictionary` query to update
        let attributes = [
            kSecValueData as String: tokenData
        ]

        // Update Keychain
        let status = SecItemUpdate(
            updateQuery as CFDictionary,
            attributes as CFDictionary
        )

        // Assert successful status
        guard status == errSecSuccess else {
            throw KeychainError.invalidStatus(status)
        }
    }

    // MARK: - Delete

    /// Delete token from Keychain
    public func deleteToken() throws {
        let oldValue = try? readToken() // Don't throw
        defer {
            postNotification(oldValue: oldValue)
        }

        // `CFDictionary` query to delete
        let deleteQuery: [String: Any] = [
            kSecClass as String: Self.classKey,
            kSecAttrApplicationTag as String: try keychainIdentifierData()
        ]

        // Delete from Keychain
        let status = SecItemDelete(deleteQuery as CFDictionary)

        // Assert successful status
        guard status == errSecSuccess else {
            throw KeychainError.invalidStatus(status)
        }
    }

    // MARK: - Notification

    /// Post a `Notification` of `KeychainToken` has changed
    ///
    /// - Parameter oldValue: `String` old token
    private func postNotification(oldValue: String?) {
        let newValue = try? readToken()
        guard newValue != oldValue else { return }

        // Post token change
        NotificationCenter.default.post(
            keychainToken: self,
            token: newValue,
            object: self
        )
    }
}
