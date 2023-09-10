import Networking
import Resolver
import TransactionsService

public struct DomainAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        TransactionsServiceAssembler(resolver: resolver)
        NetworkingAssembler(resolver: resolver)
    }
}
