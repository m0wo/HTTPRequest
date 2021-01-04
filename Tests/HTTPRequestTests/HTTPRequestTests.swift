import XCTest
@testable import HTTPRequest

/// Test `HTTPRequest`
final class HTTPRequestTests: XCTestCase {

    /// Test invalid `URLComponents` create an invalid `URLRequest`
    func test_invalidURLRequest() throws {
        var urlComponents: URLComponents = .test
        urlComponents.path = "test" // Should start with "/"

        XCTAssertThrowsError(
            try HTTPRequest(
                method: .get,
                urlComponents: urlComponents
            ).asURLRequest()
        )
    }

    /// Test valid `URLComponents` create a valid `URLRequest`
    func test_URLRequest() throws {
        let urlComponents: URLComponents = .test
        XCTAssertEqual(urlComponents.url?.absoluteString, String.test)

        let urlRequest = try HTTPRequest(
            method: .get,
            urlComponents: urlComponents
        ).asURLRequest()

        XCTAssertEqual(urlRequest.url?.absoluteString, String.test)
    }

    /// Test valid `URLComponents` with query items create a valid `URLRequest`
    /// with query items
    func test_URLRequest_query() throws {
        var urlComponents: URLComponents = .test

        let athleteId: Int = 1_735_268
        let clientId: String = UUID().uuidString
        urlComponents.queryItems = [
            URLQueryItem(name: "athleteId", value: "\(athleteId)"),
            URLQueryItem(name: "clientId", value: clientId)
        ]

        let urlRequest = try HTTPRequest(
            method: .get,
            urlComponents: urlComponents
        ).asURLRequest()

        let expected = "\(String.test)?athleteId=\(athleteId)&clientId=\(clientId)"
        XCTAssertEqual(urlRequest.url?.absoluteString, expected)
    }
}

// MARK: - URLComponents + Test

private extension URLComponents {

    /// `URLComponents` for testing purposes
    static var test: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.strava.com"
        urlComponents.path = "/api/v3"
        return urlComponents
    }
}

// MARK: - String + Test

private extension String {

    /// `String` form of `URLComponents.test`
    static let test = "https://www.strava.com/api/v3"
}
