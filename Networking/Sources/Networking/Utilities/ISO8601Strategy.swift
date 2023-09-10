import Foundation

public struct ISO8601Strategy: DateCodableStrategy {
    private static let formatter = ISO8601DateFormatter()

    public static func decode(_ value: String) throws -> Date {
        if let date = formatter.date(from: value) {
            return date
        } else {
            fatalError()
        }
    }

    public static func encode(_ date: Date) -> String {
        formatter.string(from: date)
    }
}
