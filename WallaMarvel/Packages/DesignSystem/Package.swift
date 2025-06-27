// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"])
    ],
    dependencies: [
        .package(path: "../TestExtensions")
    ],
    targets: [
        .target(
            name: "DesignSystem",
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
