//
//  Notification+DataRequest.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/01/2022.
//

import Foundation
import Alamofire

// MARK: - Notification.Name

public extension Notification.Name {

    /// `Name` of `Notification` posted when a `DataResponse` is received for a `DataRequest`
    static let dataResponse = Notification.Name(
        rawValue: "com.\(HTTPRequest.self).\(DataResponse.self)"
    )
}

// MARK: - String

private extension String {

    /// Key for `DataRequest` in `Notification` `userInfo`
    static var dataRequestInfoKey: String {
        return "\(Notification.Name.dataResponse.rawValue).\(DataRequest.self).key"
    }

    /// Key for `DataResponse` in `Notification` `userInfo`
    static var dataResponseInfoKey: String {
        return "\(Notification.Name.dataResponse.rawValue).key"
    }
}

// MARK: - Notification

private extension Notification {

    /// `DataRequest` from `userInfo`
    var dataRequest: DataRequest? {
        return userInfo?[String.dataRequestInfoKey] as? DataRequest
    }

    /// `DataResponse` from `userInfo`
    var dataResponse: DataResponse? {
        return userInfo?[String.dataResponseInfoKey] as? DataResponse
    }
}

// MARK: - NotificationCenter

public extension NotificationCenter {

    /// Post `dataRequest` and `dataResponse` on the `NotificationCenter`
    ///
    /// - Parameters:
    ///   - dataRequest: `DataRequest`
    ///   - dataResponse: `DataResponse`
    ///   - object: `Any`
    func post(dataRequest: DataRequest, dataResponse: DataResponse, object: Any) {
        post(name: .dataResponse, object: object, userInfo: [
            String.dataRequestInfoKey: dataRequest,
            String.dataResponseInfoKey: dataResponse
        ])
    }

    /// Add an observer closure invoked when a `DataResponse` is received after making a `DataRequest`
    ///
    /// - Parameters:
    ///   - object: `Any?`
    ///   - queue: `OperationQueue?`
    ///   - closure: Closure invoked
    ///
    /// - Returns: `NSObjectProtocol`
    @discardableResult
    func addObserverForDataResponse(
        object: Any? = nil,
        queue: OperationQueue? = .main,
        closure: @escaping (DataRequest, DataResponse) -> Void
    ) -> NSObjectProtocol {
        return addObserverClosure(
            forName: .dataResponse,
            object: object,
            queue: queue
        ) { sender in
            guard let dataRequest = sender.dataRequest else { return }
            guard let dataResponse = sender.dataResponse else { return }
            closure(dataRequest, dataResponse)
        }
    }
}
