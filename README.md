## HTTPRequest 

HTTPRequest constructs a declarative, `Model` driven interface to HTTP networking.  
It is a high level wrapper built on top of the awesome framework [Alamofire](https://github.com/Alamofire/Alamofire).  
How it works is best demonstrated by an example:

```swift
try AF.request(StravaAPI.athlete) { response in
    guard let athlete: Athlete = response.model() else {
        // Handle API error
        return
    }
        
    // Use athlete
}
```

This interface makes it clearer to the reader what this this network request is doing, specifically:  
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
    
    /// Strava API for `endpoint` and `parameters`
    ///
    /// - Parameters:
    ///   - endpoint: `String`
    ///   - parameters: `[URLQueryItem]`
    static func stravaAPI(
        endpoint: String,
        parameters: [URLQueryItem] = []
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

The `try` is necessary because converting from a `HTTPRequest` to a `URLRequest` may `throw` an `Error`. E.g. `URL` path component invalid etc.
It's also very possible for a request to fail while building it, for example, failed to create JSON body (encoding error).

The Strava API is just an example here, you can define your API endpoints however you want! It's the conformance to the `HTTPRequestable` that's important.

