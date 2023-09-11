import SwiftUI

struct TransactionDetailsView: View {
    @StateObject var viewModel: TransactionDetailsViewModel
    var body: some View {
        VStack {
            Text(viewModel.transaction.partnerDisplayName)
            Text(viewModel.transaction.transactionDetailDescription ?? "")
        }.navigationTitle("Details")
    }
}
