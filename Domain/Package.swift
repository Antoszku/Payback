// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v16)],
    products: [
        .library(target: .Domain),
        .library(target: .TransactionsService)
    ],
    dependencies: [
        .package(.Networking),
        .package(.DI)
    ],
    targets: [
        .target(name: .Domain, dependencies: [.Networking, .Resolver, .TransactionsService]),
        .target(name: .TransactionsService, dependencies: [.Networking, .Resolver]),
    ]
)


enum Targets: String {
    case Domain
    case TransactionsService
}

enum Dependencies: String {
    
    // Domain
    case TransactionsService
    case Networking
    
    // DI
    case Resolver
    
    func dependency() -> Target.Dependency {
        switch self {
            // Domain
        case .TransactionsService, .Networking:
            return Target.Dependency(self)
            // DI
        case .Resolver:
            return Target.Dependency(self, package: .DI)
        }
    }
}

enum Packages: String {
    case DI
    case Networking
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
    
    static func testTarget(name: Targets,
                           dependencies: [Dependencies] = [],
                           resources: [Resource]? = nil) -> Target
    {
        .testTarget(name: name.rawValue,
                    dependencies: dependencies.map { $0.dependency() },
                    path: "Tests/\(name)",
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
