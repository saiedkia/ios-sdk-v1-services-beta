// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "MapirServices",
    products: [
        .library(
            name: "MapirServices",
            targets: ["MapirServices"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/raphaelmor/Polyline.git", .upToNextMinor(from: "4.2.1"))
    ],
    targets: [
        .target(
            name: "MapirServices",
            dependencies: ["Polyline"],
            path: "Sources"
        ),
        .testTarget(
            name: "MapirServicesTests",
            dependencies: ["MapirServices"],
            path: "Tests"
        ),
    ]
)
