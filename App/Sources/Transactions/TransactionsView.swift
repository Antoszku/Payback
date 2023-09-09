import SwiftUI

struct TransactionsView: View {
    @StateObject var viewModel: TransactionsViewModel

    public var body: some View {
        VStack {
            switch viewModel.state {
            case .loading: ProgressView()
            case let .transactions(transactions): TransactionsListView(transactions: transactions)
            }
        }

            .onAppear { onAppear() }
            .environmentObject(viewModel)
    }

    private func onAppear() {
        Task {
            await viewModel.onAppear()
        }
    }

}
