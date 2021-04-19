//
//  main.swift
//  StravaAPI
//
//  Created by Ben Shutt on 07/12/2020.
//

import Alamofire
import Foundation
import HTTPRequest

do {
    HTTPRequest.Configuration.shared.logging = true

    try StravaSession.shared.configure()

    let athlete: Athlete =
        try AF.requestSync(StravaAPI.athlete).modelOrThrow()

    debugPrint(athlete)
} catch {
    debugPrint(error)
}
