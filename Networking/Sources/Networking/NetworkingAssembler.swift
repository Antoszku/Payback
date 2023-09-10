import Resolver

public struct NetworkingAssembler {
    
    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(APIClient.self, initializer: DefaultAPIClient.init)
        resolver.register(SessionService.self, initializer: DefaultSessionService.init)
        resolver.register(NetworkConfiguration.self, initializer: NetworkConfiguration.init)
    }
}
