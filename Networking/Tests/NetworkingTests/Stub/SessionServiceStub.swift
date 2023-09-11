import Foundation
@testable import Networking

final class SessionServiceStub: SessionService {
    var dataCalledWithRequest: URLRequest?
    var returnData = (Data(), HTTPURLResponse())

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataCalledWithRequest = request
        return returnData
    }
}
