// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "DI",
    products: [
        .library(
            name: "Resolver",
            targets: ["Resolver"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", from: "2.8.3"),
    ],
    targets: [
        .target(
            name: "Resolver",
            dependencies: ["SwinjectAutoregistration"]
        ),
    ]
)
