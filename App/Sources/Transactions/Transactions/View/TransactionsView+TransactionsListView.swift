import SwiftUI

extension TransactionsView {
    struct TransactionsListView: View {
        @EnvironmentObject var viewModel: TransactionsViewModel

        let transactions: [TransactionPresentable]
        let viewFactory: TransactionsViewFactory

        private let background = Color(#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9803921569, alpha: 1))

        var body: some View {
            VStack {
                Filters()
                Text("Total Amount: \(viewModel.totalAmount ?? 0)")
                TransactionsList(transactions: transactions, viewFactory: viewFactory)

            }.background(background)
        }
    }
}
