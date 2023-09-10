import Resolver
import Networking

public struct TransactionsServiceAssembler {
    
    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(TransactionsService.self, initializer: DefaultTransactionsService.init)
        NetworkingAssembler(resolver: resolver)
    }
}