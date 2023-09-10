import Foundation

public struct Request {
    let url: String
    let method: HTTPMethod

    public init(url: String,
                method: HTTPMethod)
    {
        self.url = url
        self.method = method
    }
}
