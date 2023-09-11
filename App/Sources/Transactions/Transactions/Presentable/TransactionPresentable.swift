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
}

extension TransactionPresentable {
    init(dto: TransactionDTO) {
        bookingDateDescription = dto.transactionDetail.bookingDate.formatted(.dateTime)
        id = dto.alias.reference
        bookingDate = dto.transactionDetail.bookingDate
        category = dto.category
        partnerDisplayName = dto.partnerDisplayName
        transactionDetailDescription = dto.transactionDetail.description
        amount = dto.transactionDetail.value.amount
        currency = dto.transactionDetail.value.currency
    }
}
