import PaybackKit
import Resolver

public struct NetworkingAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(APIClient.self, initializer: DefaultAPIClient.init)
        resolver.register(SessionService.self, initializer: DefaultSessionService.init)
        switch AppEnvironment.current {
        case .production:
            resolver.register(NetworkConfiguration.self, initializer: ProductionNetworkConfiguration.init)
        case .debug:
            resolver.register(NetworkConfiguration.self, initializer: DebugNetworkConfiguration.init)
        }
    }
}
