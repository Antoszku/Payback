import Networking

public protocol TransactionsService {
    func getTransactions() async throws -> [TransactionDTO]
}

struct DefaultTransactionsService: TransactionsService {
    private let apiClient: APIClient
    private let url = "/transactions"

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func getTransactions() async throws -> [TransactionDTO] {
        let request = Request(url: url,
                              method: .GET)

        let transactions: TransactionsDTO = try await apiClient.sendRequest(request)
        return transactions.items
    }
}
