public extension TransactionDTO.TransactionDetailDTO {
    struct ValueDTO: Decodable {
        public let amount: Int
        public let currency: String
    }
}
