// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [], resources: [.process("Mocks")]),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),
    ]
)
