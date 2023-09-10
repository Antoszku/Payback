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
        }
            .onAppear { onAppear() }
            .environmentObject(viewModel)
    }

    private func onAppear() {
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            await viewModel.onAppear()
        }
    }
}

