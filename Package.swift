// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTTPRequest",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "HTTPRequest",
            targets: ["HTTPRequest"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.5.0")
        )
    ],
    targets: [
        .target(
            name: "HTTPRequest",
            dependencies: ["Alamofire"],
            path: "Sources"
        ),
        .testTarget(
            name: "HTTPRequestTests",
            dependencies: ["HTTPRequest"]
        )
    ]
)
