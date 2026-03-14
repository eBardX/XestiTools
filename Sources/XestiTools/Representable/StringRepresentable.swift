// © 2023–2026 John Gary Pusey (see LICENSE.md)

public protocol StringRepresentable: Codable,
                                     Comparable,
                                     CustomStringConvertible,
                                     Equatable,
                                     ExpressibleByStringLiteral,
                                     Hashable,
                                     Sendable {
    static func isValid(_ stringValue: String) -> Bool

    init(_ stringValue: String)

    init?(stringValue: String)

    var stringValue: String { get }
}

// MARK: - (defaults)

extension StringRepresentable {
    public static func isValid(_ stringValue: String) -> Bool {
        !stringValue.isEmpty
    }

    public init(_ stringValue: String) {
        self.init(stringValue: stringValue)!    // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Codable

extension StringRepresentable where Self: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        self.init(stringValue: stringValue)!    // swiftlint:disable:this force_unwrapping
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(stringValue)
    }
}

// MARK: - Comparable

extension StringRepresentable where Self: Comparable {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.stringValue < rhs.stringValue
    }
}

// MARK: - CustomStringConvertible

extension StringRepresentable where Self: CustomStringConvertible {
    public var description: String {
        String(describing: stringValue)
    }
}

// MARK: - Equatable

extension StringRepresentable where Self: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.stringValue == rhs.stringValue
    }
}

// MARK: - ExpressibleByStringLiteral

extension StringRepresentable where Self: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(stringValue: value)!          // swiftlint:disable:this force_unwrapping
    }
}
