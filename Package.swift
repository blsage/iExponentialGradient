// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "union-gradients",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "UnionGradients",
            targets: ["UnionGradients"]
        ),
    ],
    targets: [
        .target(
            name: "UnionGradients"
        ),
    ]
)
