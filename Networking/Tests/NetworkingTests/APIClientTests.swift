@testable import Networking
import XCTest

final class APIClientTests: XCTestCase {
    func test_sendRequest_callSessionDataFor_withCorrectRequest() async {
        let session = SessionServiceStub()
        let sut = makeSut(sessionService: session)

        let _: String? = try? await sut.sendRequest(.build())

        XCTAssertEqual(session.dataCalledWithRequest?.url, URL(string: "https://api-test.payback.com/"))
        XCTAssertEqual(session.dataCalledWithRequest?.httpMethod, "GET")
    }

    func test_sendRequest_callSessionDataFor_withCorrectRequestForProduction() async {
        let session = SessionServiceStub()
        let sut = makeSut(sessionService: session, networkConfiguration: ProductionNetworkConfiguration())

        let _: String? = try? await sut.sendRequest(.build())

        XCTAssertEqual(session.dataCalledWithRequest?.url, URL(string: "https://api.payback.com/"))
        XCTAssertEqual(session.dataCalledWithRequest?.httpMethod, "GET")
    }

    func test_sendRequest_callSessionDataFor_withPOSTHTTPMethod() async {
        let session = SessionServiceStub()
        let sut = makeSut(sessionService: session)

        let _: String? = try? await sut.sendRequest(.build(method: .POST))

        XCTAssertEqual(session.dataCalledWithRequest?.httpMethod, "POST")
    }

    func test_sendRequst_returnCorrectData() async {
        let expectedResult = "test result"
        let encoded = try! JSONEncoder().encode(expectedResult)
        let session = SessionServiceStub()
        session.returnData = (encoded, HTTPURLResponse())
        let sut = makeSut(sessionService: session)

        let result: String? = try? await sut.sendRequest(.build())

        XCTAssertEqual(result, expectedResult)
    }

    func test_sendRequst_returnCorrectData_forStatusCodeBetween200and299() async {
        let expectedResult = "test result"
        let encoded = try! JSONEncoder().encode(expectedResult)
        let session = SessionServiceStub()
        session.returnData = (encoded, HTTPURLResponse(url: URL(string: "google.pl")!,
                                                       statusCode: 299,
                                                       httpVersion: nil,
                                                       headerFields: nil)!)
        let sut = makeSut(sessionService: session)

        let result: String? = try? await sut.sendRequest(.build())

        XCTAssertEqual(result, expectedResult)
    }

    func test_sendRequst_throwParsingError() async {
        let session = SessionServiceStub()
        session.returnData = (Data(), HTTPURLResponse(url: URL(string: "google.pl")!,
                                                      statusCode: 200,
                                                      httpVersion: nil,
                                                      headerFields: nil)!)
        let sut = makeSut(sessionService: session)

        do {
            let _: String = try await sut.sendRequest(.build())
            XCTFail()
        } catch APIError.parsingError {
        } catch {
            XCTFail()
        }
    }

    func test_sendRequst_throwServerError() async {
        let expectedCode = 300
        let session = SessionServiceStub()
        session.returnData = (Data(), HTTPURLResponse(url: URL(string: "google.pl")!,
                                                      statusCode: expectedCode,
                                                      httpVersion: nil,
                                                      headerFields: nil)!)
        let sut = makeSut(sessionService: session)

        do {
            let _: String = try await sut.sendRequest(.build())
            XCTFail()
        } catch let APIError.serverError(code) {
            XCTAssertEqual(code, expectedCode)
        } catch {
            XCTFail()
        }
    }

    private func makeSut(sessionService: SessionService = SessionServiceStub(),
                         networkConfiguration: NetworkConfiguration = DebugNetworkConfiguration()) -> DefaultAPIClient {
        DefaultAPIClient(session: sessionService, networkConfiguration: networkConfiguration)
    }
}
