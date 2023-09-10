import Resolver
import Domain
import App

struct MainAssembler {
    let resolver = Resolver()

    init() {
        AppAssembler(resolver: resolver)
        DomainAssembler(resolver: resolver)
    }
}
