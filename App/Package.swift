// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "App",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: AppTarget.App.rawValue, targets: [AppTarget.App.rawValue]),
        .library(name: AppTarget.Transactions.rawValue, targets: [AppTarget.Transactions.rawValue]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "DI", path: "../DI"),
    ],
    targets: [
        .target(name: .App, dependencies: [.Transactions]),
        .target(name: .Transactions, dependencies: [.TransactionsService, .Resolver]),
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
    case App

    case Transactions
}

enum DomainDependency: String {
    // Domain
    case TransactionsService
    case Resolver
    case Transactions

    func dependency() -> Target.Dependency {
        switch self {
        // Domain
        case .Transactions:
            return Target.Dependency(self)

        case .TransactionsService:
            return Target.Dependency(self, package: "Domain")

        case .Resolver:
            return Target.Dependency(self, package: "DI")
        }
    }
}
