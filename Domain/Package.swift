// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: AppTarget.Domain.rawValue, targets: [AppTarget.Domain.rawValue]),
        .library(name: AppTarget.TransactionsService.rawValue, targets: [AppTarget.TransactionsService.rawValue]),
    ],
    dependencies: [
        .package(name: "Networking", path: "../Networking"),
        .package(name: "DI", path: "../DI"),
    ],
    targets: [
        .target(name: .Domain, dependencies: [.Networking, .Resolver, .TransactionsService]),
        .target(name: .TransactionsService, dependencies: [.Networking, .Resolver]),
    ]
)

extension Target {
    static func target(name: AppTarget,
                       dependencies: [DomainDependency] = [],
                       resources: [Resource]? = nil) -> Target
    {
        .target(name: name.rawValue,
                dependencies: dependencies.map { $0.dependency() },
                path: "Sources/\(name)",
                resources: resources)
    }
}

extension Target.Dependency {
    init(_ target: DomainDependency) {
        self.init(stringLiteral: target.rawValue)
    }

    init(_ target: DomainDependency, package: String) {
        self = Target.Dependency.product(name: target.rawValue, package: package)
    }
}

enum AppTarget: String {
    case Domain

    case TransactionsService
}

enum DomainDependency: String {
    // Domain
    case TransactionsService
    case Networking
    case Resolver

    func dependency() -> Target.Dependency {
        switch self {
        // Domain
        case .TransactionsService, .Networking:
            return Target.Dependency(self)

        case .Resolver:
            return Target.Dependency(self, package: "DI")
        }
    }
}
