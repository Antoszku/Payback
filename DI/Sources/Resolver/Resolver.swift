import Swinject
import SwinjectAutoregistration

public struct Resolver {
    private let container = Container()

    public init() {}

    public func resolve<T>(_: T.Type) -> T {
        return container.resolve(T.self)!
    }

    public func register<T>(_ type: T.Type, initializer: @escaping (() -> T)) {
        container.autoregister(type, initializer: initializer)
    }

    public func register<T, A>(_ type: T.Type, initializer: @escaping ((A) -> T)) {
        container.autoregister(type, initializer: initializer)
    }

    public func register<T, A, B>(_ type: T.Type, initializer: @escaping ((A, B) -> T)) {
        container.autoregister(type, initializer: initializer)
    }
}
