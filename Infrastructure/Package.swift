// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Infrastructure",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: AppTarget.Infrastructure.rawValue, targets: [AppTarget.Infrastructure.rawValue]),
        .library(name: AppTarget.TransactionsService.rawValue, targets: [AppTarget.TransactionsService.rawValue]),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", from: "2.8.3"),
        .package(name: "Networking", path: "../Networking"),
    ],
    targets: [
        .target(name: .Infrastructure),
        .target(name: .TransactionsService, dependencies: [.Networking, .SwinjectAutoregistration
        ])
    ]
)

extension Target {
    static func target(name: AppTarget,
                       dependencies: [InfrastructureDependency] = [],
                       resources: [Resource]? = nil) -> Target
    {
        .target(name: name.rawValue,
                dependencies: dependencies.map { Target.Dependency($0) },
                path: "Sources/\(name)",
                resources: resources)
    }
}

extension Target.Dependency {
    init(_ target: InfrastructureDependency) {
        self.init(stringLiteral: target.rawValue)
    }
}

enum AppTarget: String {
    case Infrastructure
    
    case TransactionsService
}

enum InfrastructureDependency: String {
    // Infrastructure
    case Transactions
    case Networking
    case SwinjectAutoregistration
}
