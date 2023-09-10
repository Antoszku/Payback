import TransactionsService

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
