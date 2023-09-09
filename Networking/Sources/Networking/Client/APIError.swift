enum APIError: Error {
    case parsingError
    case serverError(code: Int)
}
