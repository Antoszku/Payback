import Foundation
import TransactionsService

public final class TransactionsViewModel: ObservableObject {
    enum State {
        case loading
        case transactions([TransactionPresentable])
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

protocol TransactionsInteractor {
    func getTransactions() async throws -> [TransactionPresentable]
}

final class DefaultTransactionsInteractor: TransactionsInteractor {
    private let service: TransactionsService

    init(service: TransactionsService) {
        self.service = service
    }

    func getTransactions() async throws -> [TransactionPresentable] {
        let transactionsDTO = try await service.getTransactions()
        return transactionsDTO.map { .init(dto: $0) }
    }
}

import TransactionsService

struct TransactionPresentable: Identifiable, Hashable {
    let id: String
    let bookingDate: Date
    let category: Int
    let bookingDateDescription: String
    let partnerDisplayName: String
    let transactionDetailDescription: String?
    let amount: Int
    let currency: String

    init(dto: TransactionDTO) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm d MMM yyyy"
        bookingDateDescription = dateFormatter.string(from: dto.transactionDetail.bookingDate)

        id = dto.alias.reference
        bookingDate = dto.transactionDetail.bookingDate
        category = dto.category
        partnerDisplayName = dto.partnerDisplayName
        transactionDetailDescription = dto.transactionDetail.description
        amount = dto.transactionDetail.value.amount
        currency = dto.transactionDetail.value.currency
    }
}
