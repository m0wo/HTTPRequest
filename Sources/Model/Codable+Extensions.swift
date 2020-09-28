//
//  Codable+Extensions.swift
//  Alamofire
//
//  Created by Ben Shutt on 28/09/2020.
//

import Foundation

// MARK: - StringError

/// An `Error` converting from `String` to `Data` or vice versa
public enum StringDataError: Error {
    
    /// Failed to create a `String` from the given `Data` and `String.Encoding`
    case data(Data, encoding: String.Encoding)
    
    /// Failed to create `Data` from the given `String` and `String.Encoding`
    case string(string: String, encoding: String.Encoding)
}

// MARK: - JSONDecoder

public extension JSONDecoder {
    
    /// Default `JSONDecoder`
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(
            DateFormatter.hierarchicalISO8601
        )
        return decoder
    }
}

// MARK: - JSONEncoder

public extension JSONEncoder {
    
    /// Default `JSONEncoder`
    static var `default`: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(
            DateFormatter.hierarchicalISO8601
        )
        return encoder
    }
}

// MARK: - Encodable

public extension Encodable {
    
    /// Create JSON `Data` from `Encodable`
    ///
    /// - Parameter encoder: `JSONEncoder`
    func jsonData(encoder: JSONEncoder = .default) throws -> Data {
        return try encoder.encode(self)
    }
    
    /// Use `JSONEncoder` with `.prettyPrinted` on `self`
    ///
    /// - Parameter encoder: `JSONEncoder`
    func jsonString(encoder: JSONEncoder = .default) throws -> String {
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self)
        let encoding: String.Encoding = .utf8
        guard let json = String(data: data, encoding: encoding) else {
            throw StringDataError.data(data, encoding: encoding)
        }
        
        return json
    }
}

// MARK: - Decodable

public extension Decodable {
    
    /// Create `Decodable` from JSON `Data`.
    ///
    /// - Parameters:
    ///   - jsonData: JSON `Data`
    ///   - decoder: `JSONDecoder`
    init (jsonData: Data, decoder: JSONDecoder = .default) throws {
        self = try decoder.decode(Self.self, from: jsonData)
    }
}

// MARK: - DateFormatter

/// `DateFormatter` that fallsback on date formats in a hierarchical manner.
/// A proxy `ISO8601` `DateFormatter`.
public class HierarchicalDateFormatter: DateFormatter {
    
    /// Override coverting `String` to `Date` by falling back on a selection
    /// of standard date formats
    ///
    /// - Parameter string: `String`
    public override func date(from string: String) -> Date? {
        // Starting at the front, attempt the date formats
        // in order, falling back onto the next
        let dateFormats = [
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            
            // No milliseconds
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            
            // No timeZone
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            
            // No milliseconds and no timeZone
            "yyyy-MM-dd'T'HH:mm:ss",
            
            // Date only
            "yyyy-MM-dd"
        ]
        
        for dateFormat in dateFormats {
            let formatter = DateFormatter.iso8601Formatter(
                dateFormat: dateFormat,
                timeZone: TimeZone.current
            )
            if let date = formatter.date(from: string) {
                return date
            }
        }
        
        return nil
    }
}

// MARK: - DateFormatter + Hierarchical

public extension DateFormatter {
    
    /// `HierarchicalDateFormatter` converting a `String` to a `Date`
    /// by falling back on standard, common date formats
    static let hierarchicalISO8601 = HierarchicalDateFormatter()
}
