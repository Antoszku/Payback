// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "App",
    platforms: [.iOS(.v16)],
    products: [
        .library(target: .App),
        .library(target: .Transactions),
    ],
    dependencies: [
        .package(.Domain),
        .package(.DI),
    ],
    targets: [
        .target(name: .App, dependencies: [.Transactions]),
        .target(name: .Transactions, dependencies: [.TransactionsService, .Resolver]),
    ]
)

enum Targets: String {
    case App
    case Transactions
}

enum Dependencies: String {
    // App
    case Transactions

    // Domain
    case TransactionsService

    // DI
    case Resolver

    func dependency() -> Target.Dependency {
        switch self {
        // App
        case .Transactions:
            return Target.Dependency(self)

        // Domain
        case .TransactionsService:
            return Target.Dependency(self, package: .Domain)

        // DI
        case .Resolver:
            return Target.Dependency(self, package: .DI)
        }
    }
}

enum Packages: String {
    case Domain
    case DI
}


extension Target {
    static func target(name: Targets,
                       dependencies: [Dependencies] = [],
                       resources: [Resource]? = nil) -> Target {
        .target(name: name.rawValue,
                dependencies: dependencies.map { $0.dependency() },
                path: "Sources/\(name)",
                resources: resources)
    }
}

extension Target.Dependency {
    init(_ target: Dependencies) {
        self.init(stringLiteral: target.rawValue)
    }

    init(_ target: Dependencies, package: Packages) {
        self = Self.product(name: target.rawValue, package: package.rawValue)
    }
}

extension Product {
    static func library(target: Targets) -> PackageDescription.Product {
        library(name: target.rawValue, targets: [target.rawValue])
    }

    static func library(target: Targets, targets: [Targets]) -> PackageDescription.Product {
        library(name: target.rawValue, targets: targets.map { $0.rawValue })
    }
}

extension Package.Dependency {
    static func package(_ package: Packages) -> Package.Dependency {
        Self.package(name: package.rawValue, path: "../\(package.rawValue)")
    }
}
