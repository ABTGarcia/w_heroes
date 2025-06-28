// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]
        )
    ],
    dependencies: [
        .package(path: "../TestExtensions"),
        .package(
            url: "https://github.com/hmlongco/Factory",
            from: "2.5.1"
        )
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: [
                .product(name: "FactoryKit", package: "Factory")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain", "TestExtensions"]
        )
    ]
)
