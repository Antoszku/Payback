import SwiftUI

struct TransactionsView: View {
    @StateObject var viewModel: TransactionsViewModel

    let viewFactory: TransactionsViewFactory

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading: ProgressView()
            case let .transactions(transactions): TransactionsListView(transactions: transactions, viewFactory: viewFactory)
            case .error: TryAgainView()
            }
        }.navigationTitle("Transactions")
            .onFirstAppear { onAppear() }
            .environmentObject(viewModel)
    }

    private func onAppear() {
        Task { await viewModel.loadTransactions() }
    }
}
