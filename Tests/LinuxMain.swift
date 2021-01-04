import XCTest
import HTTPRequestTests

// swiftlint:disable let_var_whitespace

var tests = [XCTestCaseEntry]()
tests += HTTPRequestTests.allTests()
XCTMain(tests)

// swiftlint:enable let_var_whitespace
