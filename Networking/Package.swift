// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
    ],
    dependencies: [
        .package(name: "DI", path: "../DI"),
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [Target.Dependency.product(name: "Resolver", package: "DI")], resources: [.process("Mocks")]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),
    ]
)
