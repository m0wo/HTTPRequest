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
HTTPRequestLogger.logAll()

// When true, print the URL of the OAuth page to get an authentication token.
// Navigate to that URL from a browser, on successful redirect, copy the returned
// code into `configure(code:)`.
// From then on, the session can be initialized with `configure(code: nil)` as
// it has a refresh token with the required scope.
let isFirstAuthentication = false

do {
    guard !isFirstAuthentication else {
        try Logger.stravaAPI.log(type: .info, message: AuthorizeURL.logString())
        exit(EXIT_SUCCESS)
    }

    // Setup Strava session
    try StravaSession.shared.configure()

    // Fetch athlete
    _ = try StravaAPI.athlete.requestSync().get()

    // Fetch activities
    _ = try StravaAPI.activities(ActivitiesRange()).requestSync().get()
} catch {
    // Log failure
    Logger.stravaAPI.log(error: error)
}
