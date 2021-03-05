//
//  KeychainError.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 11/12/2020.
//  Copyright © 2020 3 SIDED CUBE APP PRODUCTIONS LTD. All rights reserved.
//

import Foundation

/// `Error`s thrown in Keychain operations
public enum KeychainError: Error {

    /// The given `status` was not valid
    case invalidStatus(_ status: OSStatus)

    /// The `ref` returned from the Keychain was invalid
    case invalidRef(_ ref: AnyObject?)
}
