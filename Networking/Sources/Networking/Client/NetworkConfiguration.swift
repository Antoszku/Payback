struct NetworkConfiguration {
    let scheme: String
    let host: String

    init() {
        scheme = "https"
        host = "api.payback.com"
    }

//    init(scheme: String = "https", host: String = "api.payback.com") {
//        self.scheme = scheme
//        self.host = host
//    }
}
