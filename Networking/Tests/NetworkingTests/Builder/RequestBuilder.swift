import Networking

extension Request {
    static func build(method: HTTPMethod = .GET) -> Self {
        return .init(url: "/", method: method)
    }
}
