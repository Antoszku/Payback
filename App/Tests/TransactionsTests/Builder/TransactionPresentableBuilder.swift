@testable import Transactions
import Foundation

extension TransactionPresentable {
    static func build(id: String = "",
                      bookingDate: Date = Date(),
                      category: Int = 1,
                      bookingDateDescription: String = "",
                      partnerDisplayName: String = "",
                      transactionDetailDescription: String? = "",
                      amount: Int = 1,
                      currency: String = "") -> Self {
            .init(id: id,
                  bookingDate: bookingDate,
                  category: category,
                  bookingDateDescription: bookingDateDescription,
                  partnerDisplayName: partnerDisplayName,
                  transactionDetailDescription: transactionDetailDescription,
                  amount: amount,
                  currency: currency)
    }
}
