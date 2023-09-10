import Foundation

public protocol DateCodableStrategy {
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue) throws -> Date
    static func encode(_ date: Date) -> RawValue
}
