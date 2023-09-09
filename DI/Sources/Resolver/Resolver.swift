import SwinjectAutoregistration
import Swinject

public struct Resolver {
    private let container = Container()
    
    public init() { }

    public func resolve<T>(_ type: T.Type) -> T {
        return container.resolve(T.self)!
    }

    public func register<T>(_ type: T.Type, initializer: @escaping (() -> T)) {
        container.autoregister(type, initializer: initializer)
    }
}
