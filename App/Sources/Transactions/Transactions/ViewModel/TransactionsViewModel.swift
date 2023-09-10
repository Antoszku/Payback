import Foundation
import TransactionsService

final class TransactionsViewModel: ObservableObject {
    enum State {
        case loading
        case transactions([TransactionPresentable])
        case error
    }

    private let interactor: TransactionsInteractor

    @Published private(set) var state = State.loading
    @Published private(set) var categories = [Int]()
    @Published private(set) var totalAmount = 0

    private var selectedFilter: Int?
    private var transactions = [TransactionPresentable]()

    init(interactor: TransactionsInteractor) {
        self.interactor = interactor
    }

    func onAppear() async {
        do {
            let transactions = try await interactor.getTransactions().sorted(by: { $0.bookingDate > $1.bookingDate })
            let categories = Set(transactions.map { $0.category })
            await set(categories: categories)
            await set(transactions: transactions)
            await set(state: .transactions(transactions))
        } catch {}
    }

    func onFilterTap(_ filter: Int) {
        selectedFilter = filter
        let transactionsTemp = transactions.filter { $0.category == filter }
        totalAmount = transactionsTemp.map { $0.amount }.reduce(0, +)
        state = .transactions(transactionsTemp)
    }
    
    func reload() async {
        await set(state: .loading)
        await try? Task.sleep(nanoseconds: 1_000_000_000)
        await set(state: .transactions(transactions))
    }

    @MainActor
    private func set(state: State) {
        self.state = state
    }

    @MainActor
    private func set(transactions: [TransactionPresentable]) {
        totalAmount = transactions.map { $0.amount }.reduce(0, +)
        self.transactions = transactions
    }

    @MainActor
    private func set(categories: Set<Int>) {
        self.categories = Array(categories)
    }
}
