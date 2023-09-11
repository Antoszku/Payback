import Foundation // Code for recruitment purposes
import TransactionsService

protocol TransactionsInteractor {
    func getTransactions() async throws -> [TransactionPresentable]
}

struct DefaultTransactionsInteractor: TransactionsInteractor {
    private let service: TransactionsService

    init(service: TransactionsService) {
        self.service = service
    }

    func getTransactions() async throws -> [TransactionPresentable] {
        // Code for recruitment purposes
        let randomInt = Int.random(in: 1 ... 3)
        if randomInt == 1 { throw NSError(domain: "", code: 1) }
        //
        let transactionsDTO = try await service.getTransactions()
        return transactionsDTO.map { .init(dto: $0) }
    }
}
