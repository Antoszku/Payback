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
//        return response.data.map { .init(dto: $0) }
    }
}

struct TransactionsDTO: Decodable {
    let items: [TransactionDTO]
}

public struct TransactionDTO: Decodable {
    public let partnerDisplayName: String
    public let category: Int
    public let alias: AliasDTO
    public let transactionDetail: TransactionDetailDTO

    public struct AliasDTO: Decodable {
        public let reference: String
    }

    public struct TransactionDetailDTO: Decodable {
        public let description: String?
        @DateFormatted<ISO8601Strategy> public var bookingDate: Date
        public let value: ValueDTO

        public struct ValueDTO: Decodable {
            public let amount: Int
            public let currency: String
        }
    }
}

import Foundation

@propertyWrapper public struct DateFormatted<T: DateCodableStrategy>: Codable {
    private let value: T.RawValue
    public var wrappedValue: Date

    public init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
        value = T.encode(wrappedValue)
    }

    public init(from decoder: Decoder) throws {
        value = try T.RawValue(from: decoder)
        wrappedValue = try T.decode(value)
    }

    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

import Foundation

public struct ISO8601Strategy: DateCodableStrategy {
    private static let formatter = ISO8601DateFormatter()

    public static func decode(_ value: String) throws -> Date {
        if let date = formatter.date(from: value) {
            return date
        } else {
            fatalError()
        }
    }

    public static func encode(_ date: Date) -> String {
        formatter.string(from: date)
    }
}

import Foundation

public protocol DateCodableStrategy {
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue) throws -> Date
    static func encode(_ date: Date) -> RawValue
}
