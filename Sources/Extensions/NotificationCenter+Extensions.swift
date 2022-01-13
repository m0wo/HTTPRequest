//
//  NotificationCenter+Extensions.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/01/2022.
//

import Foundation

public extension NotificationCenter {

    /// Observe posted `Notification`s using `closure`
    ///
    /// - Parameters:
    ///   - name: `Notification.Name`
    ///   - object: `Any?`
    ///   - queue: `OperationQueue?`
    ///   - closure: Closure to execute when a notification is posted
    ///
    /// - Returns: `NSObjectProtocol`, discardable result as you do not need to unregister the observer
    @discardableResult
    func addObserverClosure(
        forName name: Notification.Name,
        object: Any? = nil,
        queue: OperationQueue? = .main,
        using closure: @escaping (Notification) -> Void
    ) -> NSObjectProtocol {
        return addObserver(
            forName: name,
            object: object,
            queue: queue,
            using: closure
        )
    }
}
