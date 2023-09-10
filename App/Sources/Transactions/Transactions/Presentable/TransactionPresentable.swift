import Foundation
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
