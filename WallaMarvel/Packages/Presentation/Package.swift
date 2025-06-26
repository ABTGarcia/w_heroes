// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"])
    ],
    dependencies: [
        .package(path: "../DesignSystem"),
        .package(path: "../TestExtensions"),
        .package(
          url: "https://github.com/hmlongco/Factory",
          from: "2.5.1"
        )
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: [
                "DesignSystem",
                .product(name: "FactoryKit", package: "Factory")
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
