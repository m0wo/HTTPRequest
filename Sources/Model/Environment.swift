//
//  Environment.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 28/10/2020.
//  Copyright © 2020 3 SIDED CUBE APP PRODUCTIONS LTD. All rights reserved.
//

import Foundation

/// An environment which can read from a `Bundle`'s `infoDictionary`.
/// The entity is a `RawRepresentable` with an associated value for the `bundleKey`
/// of type: `RawValue`
public protocol Environment: RawRepresentable {

    /// Default `Environment` to fallback to if the `Environment` can not be
    /// loaded from the `Bundle`
    static var `default`: Self { get }

    /// Key in the `Bundle`
    static var bundleKey: String { get }
}

// MARK: - Environment

public extension Environment {

    /// `String` key in the `Bundle`
    static var bundleKey: String {
        return "\(Self.self)"
    }

    /// Initialize with `bundle` where the value for key is the `rawValue`
    /// of the `RawRepresentable`.
    /// If read fails, fall back on `.default` defined by conformance to `Environment`.
    ///
    /// - Parameters:
    ///   - bundle: `Bundle`
    private init?(bundle: Bundle) {
        let info = bundle.infoDictionary
        guard let value = info?[Self.bundleKey] as? RawValue else { return nil }
        self.init(rawValue: value)
    }

    /// Initialize `Self` from the given `bundle` falling back on `.default`
    /// 
    /// - Parameter bundle: `Bundle`
    static func value(bundle: Bundle = .main) -> Self {
        return Self(bundle: bundle) ?? .default
    }
}
