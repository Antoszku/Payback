import Foundation

@propertyWrapper
public struct DateFormatted<T: DateCodableStrategy>: Codable {
    private let value: T.RawValue
    public var wrappedValue: Date

    public init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
        value = T.encode(wrappedValue)
    }

    public init(from decoder: Decoder) throws {
        value = try T.RawValue(from: decoder)
        wrappedValue = try T.decode(value)
    }

    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
