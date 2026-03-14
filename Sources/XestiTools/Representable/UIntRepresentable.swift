// © 2025–2026 John Gary Pusey (see LICENSE.md)

public protocol UIntRepresentable: Codable,
                                   Comparable,
                                   CustomStringConvertible,
                                   Equatable,
                                   ExpressibleByIntegerLiteral,
                                   Hashable,
                                   Sendable {
    static func isValid(_ uintValue: UInt) -> Bool

    init(_ uintValue: UInt)

    init?(uintValue: UInt)

    var uintValue: UInt { get }
}

// MARK: - (defaults)

extension UIntRepresentable {
    public static func isValid(_ uintValue: UInt) -> Bool {
        true
    }

    public init(_ uintValue: UInt) {
        self.init(uintValue: uintValue)!    // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Codable

extension UIntRepresentable where Self: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let uintValue = try container.decode(UInt.self)

        self.init(uintValue: uintValue)!    // swiftlint:disable:this force_unwrapping
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(uintValue)
    }
}

// MARK: - Comparable

extension UIntRepresentable where Self: Comparable {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.uintValue < rhs.uintValue
    }
}

// MARK: - CustomStringConvertible

extension UIntRepresentable where Self: CustomStringConvertible {
    public var description: String {
        String(describing: uintValue)
    }
}

// MARK: - Equatable

extension UIntRepresentable where Self: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.uintValue == rhs.uintValue
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension UIntRepresentable where Self: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: UInt) {
        self.init(uintValue: UInt(integerLiteral: value))!  // swiftlint:disable:this force_unwrapping
    }
}
