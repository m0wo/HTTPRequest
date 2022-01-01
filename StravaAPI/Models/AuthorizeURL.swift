//
//  AuthorizeURL.swift
//  StravaAPI
//
//  Created by Ben Shutt on 01/01/2022.
//

import Foundation
import Alamofire
import HTTPRequest

/// Wrapper of the authorize API URL
///
/// # Docs:
/// https://developers.strava.com/docs/authentication/
struct AuthorizeURL {

    /// Logged `String` for `AuthorizeURL`
    ///
    /// - Returns: `String`
    static func logString() throws -> String {
        let tokenRequest = try TokenRequestFile.read()
        let url = try AuthorizeURL(
            clientId: tokenRequest.clientId,
            redirectURLString: "http://localhost"
        ).toURL()
        return "Your authorize URL is: \(url)"
    }

    /// Client ID
    var clientId: Int

    /// `String` of `URL` to redirect to
    var redirectURLString: String

    /// Map to `URLComponents`
    var urlComponents: URLComponents {
        var urlComponents: URLComponents = .stravaAPI(endpoint: "")
        urlComponents.path = "/oauth/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: String(clientId)),
            URLQueryItem(name: "redirect_uri", value: redirectURLString),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "approval_prompt", value: "force"),
            URLQueryItem(name: "scope", value: "read_all,profile:read_all,activity:read_all")
        ]
        return urlComponents
    }

    /// Map to percent encoded (query items) `URL`
    func toURL() throws -> URL {
        let httpRequest = HTTPRequest(method: .get, urlComponents: urlComponents)
        let urlRequest = try httpRequest.asURLRequest()
        guard let url = urlRequest.url else { throw AuthorizeURLError.nilURL }
        return url
    }
}

// MARK: - Error

/// `Error` with `AuthorizeURL`
enum AuthorizeURLError: Error {

    /// `URL` was unexpectedly nil
    case nilURL
}
