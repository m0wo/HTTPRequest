## HTTPRequest 

A high level extension built on top of the awesome framework [Alamofire](https://github.com/Alamofire/Alamofire).  
How it works is best demonstrated by an example:

```swift
// Using Alamofire, make a request to the "athlete" endpoint
StravaAPI.athlete.request { result in
    // Map API result to result where the success is the model
    let modelResult: Result<Athlete, Error> = result.modelResult()
    switch modelResult {
    case let .success(athlete):
        // Use athlete
    case let .failure(error):
        // Handle error
    }
}
```

Here, we are making a HTTP request to the `"athlete"` endpoint of the Strava API and mapping to an `Athlete` model on success.
The details of the request can then be encapsulated in the `StravaAPI` `enum` (or anything that conforms to `HTTPRequestable`).
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

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. To integrate into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'HTTPRequest', :git => 'https://github.com/3sidedcube/HTTPRequest.git', :tag ~> '1.0.0'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "3sidedcube/HTTPRequest" ~> 1.0.0
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. To integrate into your project using Swift Package Manager, specify it in the `dependencies` of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/3sidedcube/HTTPRequest.git", .upToNextMajor(from: "1.0.0"))
]
```

### Notes

Converting from a `HTTPRequest` to a `URLRequest` may `throw` an `Error`. One example might be: the `URL` path component is invalid.
It's also very possible for a request to fail while building it, for example, failed to create JSON request body due to an encoding error.

The Strava API is just an example here, you can define your API endpoints however you want! It's the conformance to the `HTTPRequestable` that's important.

The framework is meant to be lightweight, it's essentially a higher layer of abstraction on top of Alamofire.

## Contributing

The (dependent) frameworks for `HTTPRequest` are installed via [Carthage](https://github.com/Carthage/Carthage) as `xcframework`s.
Simply run `./install.sh` to run the project locally.

## Example

`StravaAPI` is an example project which hits the Strava API using `HTTPRequest`.
As this API is authenticated, the setup requires providing a `TokenRefresh.json` file with the properties needed to fetch an authentication token. 
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
Note the `grant_type` is a fixed value here, the other properties will need updating.
Add this JSON  into a directory named `StravaToken` in the `PROJECT_DIR` (where the `.xcodeproj` file is located). 
The JSON file path should be: `${PROJECT_DIR}/StravaToken/TokenRefresh.json`.
Note, this directory is ignored by `git`.

As the Strava API authenticates using an OAuth flow, the first launch will require granting permission in a browser and and initializing with the code returned on success.
Then you are ready to go!
