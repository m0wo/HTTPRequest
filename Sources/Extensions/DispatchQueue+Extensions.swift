//
//  DispatchQueue+Extensions.swift
//  HTTPRequest
//
//  Created by Ben Shutt on 13/12/2021.
//

import Foundation

extension DispatchQueue {

    /// A new `DispatchQueue` identified by a random `UUID` string
    static var new: DispatchQueue {
        return DispatchQueue(label: UUID().uuidString)
    }
}
