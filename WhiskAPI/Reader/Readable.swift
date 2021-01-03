//
//  Readable.swift
//  WhiskAPI
//
//  Created by Ben Shutt on 03/01/2021.
//

import Foundation

/// Read a `String` component into an instance of `Self`
protocol Readable {
    
    /// Initialize with the given `String` component
    ///
    /// - Parameter component: `String` component
    init(component: String) throws
}
