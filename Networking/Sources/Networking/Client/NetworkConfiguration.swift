struct NetworkConfiguration {
    let scheme: String
    let host: String

    init(scheme: String = "https", host: String = "api.payback.com") {
        self.scheme = scheme
        self.host = host
    }
}
