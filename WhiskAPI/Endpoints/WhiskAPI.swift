//
//  WhiskAPI.swift
//  WhiskAPI
//
//  Created by Ben Shutt on 26/12/2020.
//

import Foundation
import HTTPRequest
import Alamofire

/// Set of Whisk APIs
enum WhiskAPI {

    /// Fetch all recipes for the logged in user
    case recipes
}

// MARK: - WhiskAPI + HTTPRequestable

extension WhiskAPI: HTTPRequestable {

    func httpRequest() throws -> HTTPRequest {
        switch self {

        case .recipes:
            return HTTPRequest(
                method: .get,
                urlComponents: .whiskAPI(
                    endpoint: "recipe/v2",
                    parameters: []
                ),
                additionalHeaders: HTTPHeaders([.acceptJSON])
            )
        }
    }
}
