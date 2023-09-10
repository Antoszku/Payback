protocol NetworkConfiguration {
    var scheme: String { get }
    var host: String { get }
}

struct ProductionNetworkConfiguration: NetworkConfiguration {
    let scheme: String
    let host: String

    init() {
        scheme = "https"
        host = "api.payback.com"
    }
}

struct DebugNetworkConfiguration: NetworkConfiguration {
    let scheme: String
    let host: String

    init() {
        scheme = "https"
        host = "api-test.payback.com"
    }
}
