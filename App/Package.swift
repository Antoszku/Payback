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
        .package(name: "Infrastructure", path: "../Infrastructure"),
        .package(name: "DI", path: "../DI")
    ],
    targets: [
        .target(name: .App, dependencies: [.Transactions]),
        .target(name: .Transactions, dependencies: [.TransactionsService, .Resolver])
    ]
)

extension Target {
    static func target(name: AppTarget,
                       dependencies: [InfrastructureDependency] = [],
                       resources: [Resource]? = nil) -> Target
    {
        .target(name: name.rawValue,
                dependencies: dependencies.map { $0.dependency() },
                path: "Sources/\(name)",
                resources: resources)
    }
}

extension Target.Dependency {
    init(_ target: InfrastructureDependency) {
        self.init(stringLiteral: target.rawValue)
    }
    init(_ target: InfrastructureDependency, package: String) {
        self = Target.Dependency.product(name: target.rawValue, package: package)
    }
}

enum AppTarget: String {
    case App
    
    case Transactions
}

enum InfrastructureDependency: String {
    // Infrastructure
    case TransactionsService
    case Resolver
    case Transactions
    
    func dependency() -> Target.Dependency {
        switch self {
            // Infrastructure
        case .Transactions:
            return Target.Dependency(self)
            
        case .TransactionsService:
            return Target.Dependency(self, package: "Infrastructure")
            
        case .Resolver:
            return Target.Dependency(self, package: "DI")
        }
    }
}
