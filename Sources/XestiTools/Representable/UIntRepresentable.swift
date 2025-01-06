// © 2025 John Gary Pusey (see LICENSE.md)

public protocol UIntRepresentable: Codable,
                                   Comparable,
                                   CustomStringConvertible,
                                   Equatable,
                                   ExpressibleByIntegerLiteral,
                                   Hashable {
    static var invalidMessage: String { get }

    static func isValid(_ uintValue: UInt) -> Bool

    static func requireValid(_ uintValue: UInt,
                             file: StaticString,
                             line: UInt) -> UInt

    init?(uintValue: UInt)

    init(_ uintValue: UInt)

    var uintValue: UInt { get }
}

// MARK: - (defaults)

extension UIntRepresentable {
    public static var invalidMessage: String {
        "uint value must be valid"
    }

    public static func isValid(_ uintValue: UInt) -> Bool {
        true
    }

    public static func requireValid(_ uintValue: UInt,
                                    file: StaticString = #file,
                                    line: UInt = #line) -> UInt {
        precondition(isValid(uintValue),
                     invalidMessage,
                     file: file,
                     line: line)

        return uintValue
    }

    public init?(uintValue: UInt) {
        guard Self.isValid(uintValue)
        else { return nil }

        self.init(uintValue)
    }
}

// MARK: - Codable

extension UIntRepresentable where Self: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let uintValue = try container.decode(UInt.self)

        self.init(uintValue)
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
        uintValue.description
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
        self.init(UInt(integerLiteral: value))
    }
}
