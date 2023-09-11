import Foundation
import TransactionsService

final class TransactionsViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case transactions([TransactionPresentable])
        case error
    }

    @Published private(set) var state = State.loading
    @Published private(set) var categories = [Int]()
    @Published private(set) var totalAmount: Int?
    @Published private(set) var selectedFilter: Int?

    private let interactor: TransactionsInteractor

    private var transactions = [TransactionPresentable]()

    init(interactor: TransactionsInteractor) {
        self.interactor = interactor
    }

    func onFilterTap(_ filter: Int) {
        if selectedFilter == filter {
            selectedFilter = nil
            totalAmount = nil
            state = .transactions(transactions)
        } else {
            selectedFilter = filter
            let filteredTransactions = transactions.filter { $0.category == filter }
            totalAmount = filteredTransactions.map { $0.amount }.reduce(0, +)
            state = .transactions(filteredTransactions)
        }
    }

    func loadTransactions() async {
        do {
            await set(state: .loading)
            await turnOffFilter()
            try await Task.sleep(nanoseconds: 1_000_000_000) // Code for recruitment purposes
            let transactions = try await interactor.getTransactions().sorted(by: { $0.bookingDate > $1.bookingDate })
            let categories = transactions.map { $0.category }
            await set(categories: categories)
            await set(transactions: transactions)
            await set(state: .transactions(transactions))
        } catch {
            await set(state: .error)
        }
    }

    @MainActor
    private func turnOffFilter() {
        selectedFilter = nil
        totalAmount = nil
    }

    @MainActor
    private func set(state: State) {
        self.state = state
    }

    @MainActor
    private func set(transactions: [TransactionPresentable]) {
        self.transactions = transactions
    }

    @MainActor
    private func set(categories: [Int]) {
        self.categories = Array(Set(categories)).sorted()
    }
}
