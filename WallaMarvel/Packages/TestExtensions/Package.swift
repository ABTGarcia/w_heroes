// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestExtensions",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "TestExtensions",
            targets: ["TestExtensions"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.12.0"
        ),
        .package(
            url: "https://github.com/hmlongco/Factory",
            from: "2.5.1"
        )
    ],
    targets: [
        .target(
            name: "TestExtensions",
            dependencies: [
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
                "Factory"
            ],
            path: "Sources"
        )
    ]
)
