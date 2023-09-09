import Foundation

class TransactionDetailsViewModel: ObservableObject {
    @Published var transaction: TransactionPresentable

    init(transaction: TransactionPresentable) {
        self.transaction = transaction
    }
}
