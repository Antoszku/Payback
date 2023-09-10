import Foundation
import Networking

public extension TransactionDTO {
    struct TransactionDetailDTO: Decodable {
        public let description: String?
        @DateFormatted<ISO8601Strategy> public var bookingDate: Date
        public let value: ValueDTO
    }
}
