// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            from: "8.3.3"
        ),
        .package(path: "../TestExtensions")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "Kingfisher", package: "Kingfisher")
            ],
            path: "Sources",
            resources: [
                .process("Resources/Images.xcassets"),
                .process("Resources/Colors.xcassets"),
                .process("Resources/Localizable.xcstrings")
            ]
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: [
                "DesignSystem",
                "TestExtensions"
            ]
        )
    ]
)
