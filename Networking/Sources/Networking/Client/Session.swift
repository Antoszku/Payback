import Foundation

protocol SessionService {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

final class DefaultSessionService: SessionService {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(for: request)
    }
}
