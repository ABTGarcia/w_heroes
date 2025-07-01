// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"]
        )
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../DesignSystem"),
        .package(path: "../TestExtensions"),
        .package(
            url: "https://github.com/hmlongco/Factory",
            from: "2.5.1"
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            from: "8.3.3"
        )
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: [
                "Domain",
                "DesignSystem",
                .product(name: "FactoryKit", package: "Factory"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: [
                "Presentation",
                "TestExtensions"
            ],
            path: "Tests"
        )
    ]
)
