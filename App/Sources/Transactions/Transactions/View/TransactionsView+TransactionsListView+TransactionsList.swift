import SwiftUI

extension TransactionsView.TransactionsListView {
    struct TransactionsList: View {
        @EnvironmentObject var viewModel: TransactionsViewModel

        let transactions: [TransactionPresentable]
        let viewFactory: TransactionsViewFactory

        var body: some View {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(transactions) { transaction in
                        NavigationLink(value: transaction) {
                            Cell(transaction: transaction)
                                .padding(.vertical, 8)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }.navigationDestination(for: TransactionPresentable.self, destination: { transaction in
                    viewFactory.makeTransactionDetails(transaction: transaction)
                })
            }.refreshable {
                Task { await viewModel.loadTransactions() }
            }
        }
    }
}
