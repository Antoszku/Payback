import Resolver
public struct TransactionsAssembler {
    
    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(TransactionsInteractor.self, initializer: DefaultTransactionsInteractor.init)
    }
}
