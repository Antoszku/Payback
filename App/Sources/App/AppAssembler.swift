import Resolver
import Transactions

public final class AppAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        TransactionsAssembler(resolver: resolver)
    }
}
