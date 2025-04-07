// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iExponentialGradient",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "iExponentialGradient",
            targets: ["iExponentialGradient"]
        ),
    ],
    targets: [
        .target(
            name: "iExponentialGradient"
        ),
    ]
)
