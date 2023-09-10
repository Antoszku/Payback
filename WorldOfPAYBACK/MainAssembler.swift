import App
import Domain
import Resolver

struct MainAssembler {
    let resolver = Resolver()

    init() {
        AppAssembler(resolver: resolver)
        DomainAssembler(resolver: resolver)
//        AppEnvironment.Setup()
    }
}
