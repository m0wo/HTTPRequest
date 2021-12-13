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

    // Fetch `Athlete` model based on authorization token
    let athlete: Athlete = try StravaAPI.athlete.requestSync().model()

    // Map to JSON String
    let jsonString = try athlete.jsonString()

    // Log success
    Logger.log(jsonString, type: .info)
} catch {
    // Log failure
    Logger.log(error)
}
