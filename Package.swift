// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "swift-staticdatetime",
    products: [
        .library(
            name: "StaticDateTimes",
            targets: ["StaticDateTimes"]
        ),
    ],
    dependencies: [
        // Protocol buffers
        .package(url: "https://github.com/apple/swift-protobuf", from: "1.30.0"),
    ],
    targets: [
        .target(
            name: "StaticDateTimes",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            path: "Sources/swift-staticdatetime"
        ),
        .testTarget(
            name: "swift-staticdatetimeTests",
            dependencies: [
                "StaticDateTimes",
            ]
        )
    ]
)
