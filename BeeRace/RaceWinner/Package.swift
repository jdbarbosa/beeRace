// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RaceWinner",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RaceWinner",
            targets: ["RaceWinner"]),
    ],
    dependencies: [
        .package(path: "../Locator"),
        .package(path: "../Models"),
        .package(path: "../Protocols"),
        .package(path: "../APIClient")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RaceWinner",
            dependencies: ["Protocols", "Locator", "APIClient", "Models"]
        ),
        .testTarget(
            name: "RaceWinnerTests",
            dependencies: ["RaceWinner"]
        ),
    ]
)
