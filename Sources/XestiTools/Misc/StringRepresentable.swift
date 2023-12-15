public protocol StringRepresentable: Codable,
                                     Comparable,
                                     CustomStringConvertible,
                                     Equatable,
                                     ExpressibleByStringLiteral,
                                     Hashable {
    static var invalidMessage: String { get }

    static func isValid(_ stringValue: String) -> Bool

    init?(stringValue: String)

    init(_ stringValue: String)

    var stringValue: String { get }
}

// MARK: - (defaults)

extension StringRepresentable {
    public init?(stringValue: String) {
        guard Self.isValid(stringValue)
        else { return nil }

        self.init(stringValue)
    }
}

// MARK: - Codable

extension StringRepresentable where Self: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        self.init(stringValue)
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
        stringValue.description
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
        self.init(value)
   }
}
