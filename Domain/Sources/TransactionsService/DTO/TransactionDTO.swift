public struct TransactionDTO: Decodable {
    public let partnerDisplayName: String
    public let category: Int
    public let alias: AliasDTO
    public let transactionDetail: TransactionDetailDTO
}
