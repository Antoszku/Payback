@testable import Transactions

final class TransactionsInteractorStub: TransactionsInteractor {
    var throwError: Error?
    var getTransactionsCalled = false
    var returnTransactions = [TransactionPresentable]()

    func getTransactions() async throws -> [TransactionPresentable] {
        getTransactionsCalled = true
        if let throwError {
            throw throwError
        }
        return returnTransactions
    }
}
