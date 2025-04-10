// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "swift-staticdatetime",
    products: [
        .library(
            name: "StaticDateTimes",
            targets: ["StaticDateTimes"]),
    ],
    targets: [
        .target(
            name: "StaticDateTimes",
            path: "Sources/swift-staticdatetime"
        ),
        .testTarget(
            name: "swift-staticdatetimeTests",
            dependencies: ["StaticDateTimes"]
        )
    ]
)
