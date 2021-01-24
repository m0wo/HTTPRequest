//
//  HTTPRequest+Build.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 24/01/2021.
//

import Foundation
import Alamofire

public extension HTTPRequest {

    /// Set `method` and return `self`
    ///
    /// - Parameter method: `HTTPMethod`
    mutating func setting(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }

    /// Set `urlComponents` and return `self`
    ///
    /// - Parameter urlComponents: `URLComponents`
    mutating func setting(_ urlComponents: URLComponents) -> Self {
        self.urlComponents = urlComponents
        return self
    }

    /// Set `timeoutInterval` and return `self`
    ///
    /// - Parameter timeoutInterval: `TimeInterval`
    mutating func setting(_ timeoutInterval: TimeInterval) -> Self {
        self.timeoutInterval = timeoutInterval
        return self
    }

    // MARK: - Headers

    /// Set `headers` and return `self`
    ///
    /// - Parameter headers: `HTTPHeaders`
    mutating func setting(_ headers: HTTPHeaders) -> Self {
        self.headers = headers
        return self
    }

    /// Add `headers` to `self.headers` and return `self`
    ///
    /// - Parameter headers: `HTTPHeader`
    mutating func adding(_ headers: HTTPHeader ...) -> Self {
        headers.forEach {
            self.headers.add($0)
        }
        return self
    }

    // MARK: - Body

    /// Set `self.body` to `body` and add the `.contentTypeJSON` `HTTPHeader`
    ///
    /// - Parameter body: `Data` for JSON body
    mutating func settingJsonBody(_ body: Data) -> Self {
        self.body = body
        return adding(.contentTypeJSON)
    }

    /// Execute `settingJsonBody(_:)` by encoding `encodable` with `encoder`
    ///
    /// - Parameters:
    ///   - encodable: `T` where `T` conforms to `Encodable`
    ///   - encoder: `JSONEncoder`
    mutating func settingJsonBody<T>(
        _ encodable: T,
        encoder: JSONEncoder = .default
    ) throws -> Self where T: Encodable {
        let body = try encoder.encode(encodable)
        return settingJsonBody(body)
    }
}
