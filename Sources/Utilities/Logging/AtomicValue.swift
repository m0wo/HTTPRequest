//
//  AtomicBool.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 09/03/2022.
//

import Foundation

/// Wrap a stored value with a serial `DispatchQueue`
public final class AtomicValue<Value> {

    /// Stored value
    private var storedValue: Value

    /// Queue for atomic operations
    private let dispatchQueue = DispatchQueue(label: "\(AtomicValue.self).queue")

    /// Memberwise initializer
    ///
    /// - Parameters:
    ///   - value: `Value`
    public init(_ value: Value) {
        self.storedValue = value
    }

    /// Get and set `storedValue` with synchronous reads and asynchronous sets on `dispatchQueue`
    public var value: Value {
        get {
            return dispatchQueue.sync {
                storedValue
            }
        }
        set {
            dispatchQueue.async {
                self.storedValue = newValue
            }
        }
    }
}
