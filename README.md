## HTTPRequest 

HTTPRequest constructs a `Model` driven interface to HTTP networking.  
It is a high level extension built on top of the awesome framework [Alamofire](https://github.com/Alamofire/Alamofire).  
How it works is best demonstrated by an example:

```swift
// Using Alamofire, make a request to the "athlete" endpoint 
AF.request(StravaAPI.athlete) { response in
    // Check the response can be decoded into an `Athlete` model
    guard let athlete: Athlete = response.model() else {
        // Handle API or `Model` error
        return
    }
        
    // Use athlete fetched from API
}
```

This interface makes it clearer to the reader what this network request is doing, specifically:  
Making a HTTP request to the `"athlete"` endpoint of the Strava API which returns an `Athlete` on success.

The details of the request can then be encapsulated in the `StravaAPI` `enum`.  
Here's what that might look like:

```swift
/// Set of endpoints for the Strava API
enum StravaAPI {

    /// Fetch (logged in) `Athlete` based on authorization token
    case athlete
}

/// Define a `HTTPRequest` based on the `StravaAPI` endpoint
extension StravaAPI: HTTPRequestable {
    
    /// Map `StravaAPI` to a `HTTPRequest`
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

The (dependent) frameworks for `HTTPRequest` are installed via [Carthage](https://github.com/Carthage/Carthage) as `xcframework`s.
Simply run `./install.sh` to run the project locally.

## Example

`StravaAPI` is an example project which hits the Strava API using `HTTPRequest`.
As this API is authenticated, the only setup required is to provide a `StravaTokenRequest.json`  file with the properties needed to fetch an authentication token. 
You can find these details by:
- Logging in to Strava
- Go to "Settings"
- Click on "My API Application"

The JSON should look like so:
```json
{
  "client_id": 123456789,
  "refresh_token": "{yourRefreshToken}",
  "client_secret": "{yourClientSecret}",
  "grant_type": "refresh_token"
}
```
Note the `grant_type` is a fixed value here, the other properties will need updating!
Add this JSON  into a directory named `StravaToken` in the `PROJECT_DIR` (where the `.xcodeproj` file is located). 
This directory is ignored by `git`.
The JSON file path would look like: `${PROJECT_DIR}/StravaToken/StravaTokenRequest.json`.
Then you are ready to go!

