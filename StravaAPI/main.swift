//
//  main.swift
//  StravaAPI
//
//  Created by Ben Shutt on 07/12/2020.
//

import Foundation
import Alamofire
import HTTPRequest

// Turn on logging
HTTPRequest.Configuration.shared.logging = true

// When true, print the URL of the OAuth page to get an authentication token.
// Navigate to that URL from a browser, on successful redirect, copy the returned
// code into `configure(code:)`.
// From then on, the session can be initialized with `configure(code: nil)` as
// it has a refresh token with the required scope.
let isFirstAuthentication = false

do {
    guard !isFirstAuthentication else {
        try Logger.log(AuthorizeURL.logString(), type: .info)
        exit(EXIT_SUCCESS)
    }

    // Setup Strava session
    try StravaSession.shared.configure()

    // Fetch athlete
    _ = try StravaAPI.athlete.requestSync().successOrThrow()

    // Fetch activities
    _ = try StravaAPI.activities(ActivitiesRange()).requestSync().successOrThrow()
} catch {
    // Log failure
    Logger.log(error)
}
