import Foundation

final class DefaultDecoder {
    func decode<T: Decodable>(data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch {
            print("[Error JSON parsing]: \(error)")
            print(error)
            // TODO: Send parsing error to analytics
            throw APIError.parsingError
        }
    }
}
