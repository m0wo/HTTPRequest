//
//  NotificationCenter+KeychainToken.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 15/01/2021.
//  Copyright © 2021 3 SIDED CUBE APP PRODUCTIONS LTD. All rights reserved.
//

import Foundation

// MARK: - Notification.Name

public extension Notification.Name {

    /// `Notification` fired when the `KeychainToken` updates
    static let keychainToken = Notification.Name(
        "com.\(HTTPRequest.self).\(KeychainToken.self)"
    )
}

// MARK: - String

private extension String {

    /// Key in the `userInfo` of the `Notification` to find the `KeychainToken`
    static var keychainTokenUserInfoKey: String {
        return Notification.Name.keychainToken.rawValue + ".key"
    }

    /// Key in the `userInfo` of the `Notification` to find the `String` token
    static var tokenUserInfoKey: String {
        return Notification.Name.keychainToken.rawValue + ".token.key"
    }
}

// MARK: - Notification

private extension Notification {

    /// `KeychainToken` from `userInfo`
    var keychainToken: KeychainToken? {
        return userInfo?[String.keychainTokenUserInfoKey] as? KeychainToken
    }

    /// `String` token from `userInfo`
    var token: String? {
        return userInfo?[String.tokenUserInfoKey] as? String
    }
}

// MARK: - NotificationCenter

public extension NotificationCenter {

    /// Post of this `NotificationCenter` a `Notification` for the
    /// `keychainToken` and `token`
    ///
    /// - Parameters:
    ///   - keychainToken: `KeychainToken`
    ///   - token: `String` token
    ///   - object: `Any`
    func post(keychainToken: KeychainToken, token: String?, object: Any) {
        post(name: .keychainToken, object: object, userInfo: [
            String.keychainTokenUserInfoKey: keychainToken,
            String.tokenUserInfoKey: token ?? NSNull()
        ])
    }

    /// Add an observer closure for `KeychainToken`
    ///
    /// - Parameters:
    ///   - object: `Any?`
    ///   - queue: `OperationQueue?`
    ///   - closure: Closure invoked
    ///
    /// - Returns: `NSObjectProtocol`
    @discardableResult
    func addObserverForKeychainToken(
        object: Any? = nil,
        queue: OperationQueue? = .main,
        closure: @escaping (KeychainToken, String?) -> Void
    ) -> NSObjectProtocol {
        return addObserverClosure(
            forName: .keychainToken,
            object: object,
            queue: queue
        ) { sender in
            guard let keychainToken = sender.keychainToken else { return }
            closure(keychainToken, sender.token)
        }
    }
}
