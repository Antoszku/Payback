import Networking
import Resolver

public struct TransactionsServiceAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(TransactionsService.self, initializer: DefaultTransactionsService.init)
    }
}
