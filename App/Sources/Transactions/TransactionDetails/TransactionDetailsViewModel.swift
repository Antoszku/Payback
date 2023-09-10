import SwiftUI

struct TransactionDetailsView: View {
    @StateObject var viewModel: TransactionDetailsViewModel
    var body: some View {
//        NavigationStack {
        Text("EXAMPLE")
        NavigationLink(value: "123") {
            Text(viewModel.transaction.bookingDateDescription)

//            }
        }.navigationDestination(for: String.self) { text in
            Text(text)
        }
    }
}
