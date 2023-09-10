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
                Text("Total Amount: \(viewModel.totalAmount)")
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
                    Task { await viewModel.reload() }
                }
            }.background(background)
        }
    }
}

struct Filters: View {
    @EnvironmentObject var viewModel: TransactionsViewModel
    var body: some View {
        HStack {
            Text("Filters:").padding(.leading)
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Text("\(category)")
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                            .onTapGesture { viewModel.onFilterTap(category) }
                    }
                }
            }
        }.padding(.vertical, 16)
    }
}
