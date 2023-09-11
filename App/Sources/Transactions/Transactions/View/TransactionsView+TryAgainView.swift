import SwiftUI

extension TransactionsView {
    struct TryAgainView: View {
        @EnvironmentObject var viewModel: TransactionsViewModel

        var body: some View {
            VStack {
                Text("Something went wrong, please try again")
                Button {
                    Task { await viewModel.loadTransactions() }
                } label: {
                    VStack {
                        Text("Try again").font(.system(size: 20)).fontWeight(.semibold).foregroundColor(.white)
                    }.frame(width: 240, height: 48).background(.gray).cornerRadius(8)
                }
            }
        }
    }
}
