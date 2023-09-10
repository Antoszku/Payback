import Foundation
import PaybackKit

struct Mocker {
    private let activeMocks = [MockData(urlPath: "/transactions", jsonFileName: "PBTransactions")]

    func returnMockData<T: Decodable>(_ request: Request, decoder: DefaultDecoder) -> T? {
        guard AppEnvironment.isDebug else { return nil }

        for mock in activeMocks {
            guard request.url == mock.urlPath else { return nil }

            guard let mockDataURL = Bundle.module.url(forResource: mock.jsonFileName, withExtension: "json"),
                  let data = try? Data(contentsOf: mockDataURL),
                  let decodedData: T = try? decoder.decode(data: data) else {
                assertionFailure("Invalid data or no file for jsonFileName: \(mock.jsonFileName)")
                return nil
            }

            return decodedData
        }

        return nil
    }
}
