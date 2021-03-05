//
//  NotificationCenter+KeychainToken.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 15/01/2021.
//  Copyright © 2021 3 SIDED CUBE APP PRODUCTIONS LTD. All rights reserved.
//

import Foundation

// MARK: - NSNotification.Name

public extension NSNotification.Name {

    /// `Notification` fired when the `KeychainToken` updates
    static let token = Notification.Name(
        "com.\(HTTPRequest.self).\(KeychainToken.self)".lowercased()
    )
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
    func post(
        keychainToken: KeychainToken,
        token: String?,
        object: Any
    ) {
        post(
            name: .token,
            object: object,
            userInfo: [
                String.keychainTokenUserInfoKey: keychainToken,
                String.tokenUserInfoKey: token ?? NSNull()
            ]
        )
    }
}

// MARK: - String

public extension String {

    /// Key in the `userInfo` of the `Notification` to find the `KeychainToken`
    static let keychainTokenUserInfoKey =
        Notification.Name.token.rawValue + ".key"

    /// Key in the `userInfo` of the `Notification` to find the `String` token
    static let tokenUserInfoKey =
        Notification.Name.token.rawValue + ".token.key"
}
