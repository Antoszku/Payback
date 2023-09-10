public enum AppEnvironment {
    public enum Target {
        case debug
        case production
    }

    public private(set) static var current: Target = .debug
    public static var isProduction: Bool {
        return current == .production
    }

    public static var isDebug: Bool {
        return current == .debug
    }

    public static func setup(as target: Target) {
        current = target
    }
}
