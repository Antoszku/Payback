import SwiftUI

extension TransactionsView.TransactionsListView {
    struct Cell: View {
        let transaction: TransactionPresentable
        var body: some View {
            VStack(alignment: .leading) {
                Text(transaction.bookingDateDescription)
                Text(transaction.transactionDetailDescription ?? "")
                HStack {
                    Text(transaction.partnerDisplayName)
                    Spacer()
                    Text("\(transaction.amount) \(transaction.currency)")
                }
            }.padding(8)
                .background(.white)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1))
                .padding(.horizontal)
        }
    }
}
