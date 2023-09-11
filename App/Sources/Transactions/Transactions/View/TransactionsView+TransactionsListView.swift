import SwiftUI

extension TransactionsView {
    struct TransactionsListView: View {
        @EnvironmentObject var viewModel: TransactionsViewModel

        let transactions: [TransactionPresentable]
        let viewFactory: TransactionsViewFactory

        private let background = Color(#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9803921569, alpha: 1))

        var body: some View {
            VStack(spacing: 0) {
                Filters()
                TransactionsList(transactions: transactions, viewFactory: viewFactory)
                if let amount = viewModel.totalAmount {
                    VStack {
                        Text("Total Amount: \(amount)")
                    }.frame(maxWidth: .infinity).padding(8).background(Color.gray.opacity(0.3))
                }
            }.background(background)
        }
    }
}
