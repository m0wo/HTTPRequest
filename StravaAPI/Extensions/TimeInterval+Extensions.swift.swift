//
//  TimeInterval+Extensions.swift.swift
//  StravaAPI
//
//  Created by Ben Shutt on 12/01/2022.
//

import Foundation

// MARK: - TimeInterval + Extensions

extension TimeInterval {

    /// Epoch `Date`
    var epochDate: Date {
        return Date(timeIntervalSince1970: self)
    }
}

// MARK: - Int + Extensions

extension Int {

    /// Epoch `Date`
    var epochDate: Date {
        return TimeInterval(self).epochDate
    }
}
