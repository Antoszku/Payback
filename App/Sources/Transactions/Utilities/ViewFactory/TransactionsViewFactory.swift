import Resolver
import SwiftUI

public struct TransactionsViewFactory {
    public var rootView: AnyView { AnyView(makeTransactions()) }

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    private let resolver: Resolver

    func makeTransactions() -> TransactionsView {
        let interactor = resolver.resolve(TransactionsInteractor.self)
        let viewModel = TransactionsViewModel(interactor: interactor)
        return TransactionsView(viewModel: viewModel, viewFactory: self)
    }

    func makeTransactionDetails(transaction: TransactionPresentable) -> TransactionDetailsView {
        return TransactionDetailsView(viewModel: .init(transaction: transaction))
    }
}
