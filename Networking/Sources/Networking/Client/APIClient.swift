import Foundation

public protocol APIClient {
    func sendRequest<T: Decodable>(_ request: Request) async throws -> T
}

final class DefaultAPIClient: APIClient {
    private let session: SessionService
    private let networkConfiguration: NetworkConfiguration
    private let decoder = DefaultDecoder()

    init(session: SessionService, networkConfiguration: NetworkConfiguration) {
        self.session = session
        self.networkConfiguration = networkConfiguration
    }

    public func sendRequest<T: Decodable>(_ request: Request) async throws -> T {
        do {
            let urlRequest = try makeURLRequest(request: request)
            print("[URL]: \(urlRequest.url?.description ?? "")")
            if let data: T = Mocker().returnMockData(request, decoder: decoder) {
                return data
            }
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else { fatalError("Should never happen") }

            switch response.statusCode {
            case 200 ... 299:
                print("[Response]:")
                printPrettyJson(for: data)
                return try decoder.decode(data: data)

            default:
                throw APIError.serverError(code: response.statusCode)
            }
        }
    }

    private func makeURLRequest(request: Request) throws -> URLRequest {
        var urlComponents = URLComponents(string: request.url)
        urlComponents?.scheme = networkConfiguration.scheme
        urlComponents?.host = networkConfiguration.host

        guard let url = urlComponents?.url else { fatalError("Should never happen since Request type have URL type inside") }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
    }

    private func printPrettyJson(for data: Data) {
        guard let object = try? JSONSerialization.jsonObject(with: data, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return }

        print(prettyPrintedString)
    }
}
