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

do {
    // Setup Strava session
    try StravaSession.shared.configure()

    // Log authorization URL
    try Logger.log(AuthorizeURL.logString(), type: .info)

    // Fetch `Athlete` model based on authorization token
    let athlete: Athlete = try StravaAPI.athlete.requestSync().model()

    // Map to JSON String
    let jsonString = try athlete.jsonString()

    // Log success
    Logger.log(jsonString, type: .info)

    // Get last weeks activities
    _ = try StravaAPI.activities(ActivitiesRange()).requestSync()
} catch {
    // Log failure
    Logger.log(error)
}
