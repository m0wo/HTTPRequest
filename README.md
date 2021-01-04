## HTTPRequest 

HTTPRequest constructs a declarative, `Model` driven interface to HTTP networking.  
It is a high level extension built on top of the awesome framework [Alamofire](https://github.com/Alamofire/Alamofire).  
How it works is best demonstrated by an example:

```swift
AF.request(StravaAPI.athlete) { response in
    guard let athlete: Athlete = response.model() else {
        // Handle API or Model error
        return
    }
        
    // Use athlete
}
```

This interface makes it clearer to the reader what this network request is doing, specifically:  
Making a HTTP request to the `"athlete"` endpoint of the Strava API which returns an `Athlete` on success.

The details of the request can then be encapsulated in the `StravaAPI` `enum`.  
Here's what that might look like:

```swift
/// Set of endpoints for the Strava API
enum StravaAPI {

    /// Fetch (logged in) `Athlete` based on authorization code
    case athlete
}

/// Define a `HTTPRequest` based on the `StravaAPI` endpoint
extension StravaAPI: HTTPRequestable {
    
    /// Construct `HTTPRequest` 
    func httpRequest() throws -> HTTPRequest {
        switch self {
        case .athlete:
            return HTTPRequest(
                method: .get,
                urlComponents: .stravaAPI(endpoint: "athlete"),
                additionalHeaders: HTTPHeaders(headers: [
                    .acceptJSON,
                    .authorization
                ])
            )
        }
    }
}

/// `URLComponents` template for Strava API HTTP requests
extension URLComponents {
    
    /// Strava API for `endpoint` and `queryItems`
    ///
    /// - Parameters:
    ///   - endpoint: `String`
    ///   - queryItems: `[URLQueryItem]`
    static func stravaAPI(
        endpoint: String,
        queryItems: [URLQueryItem] = []
    ) -> URLComponents {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "www.strava.com"
        urlComponents.path = "/api/v3/\(endpoint)"
        urlComponents.queryItems = queryItems 

        return urlComponents
    }
}
```

### Notes

Converting from a `HTTPRequest` to a `URLRequest` may `throw` an `Error`. One example might be: the `URL` path component is invalid.
It's also very possible for a request to fail while building it, for example, failed to create JSON request body due to an encoding error.

The Strava API is just an example here, you can define your API endpoints however you want! It's the conformance to the `HTTPRequestable` that's important.

This framework is lightweight, it was built to add the `Model` protocol and a simple way of building `HTTPRequest`s in Alamofire.

## Install

The (dependent) frameworks for `HTTPRequest` are installed via [Carthage](https://github.com/Carthage/Carthage).
Simply run `./install.sh` to run the project locally.
