// © 2024–2026 John Gary Pusey (see LICENSE.md)

public protocol IntRepresentable: Codable,
                                  Comparable,
                                  CustomStringConvertible,
                                  Equatable,
                                  ExpressibleByIntegerLiteral,
                                  Hashable,
                                  Sendable {
    static func isValid(_ intValue: Int) -> Bool

    init(_ intValue: Int)

    init?(intValue: Int)

    var intValue: Int { get }
}

// MARK: - (defaults)

extension IntRepresentable {
    public static func isValid(_ intValue: Int) -> Bool {
        true
    }

    public init(_ intValue: Int) {
        self.init(intValue: intValue)!  // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Codable

extension IntRepresentable where Self: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let intValue = try container.decode(Int.self)

        self.init(intValue: intValue)!  // swiftlint:disable:this force_unwrapping
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(intValue)
    }
}

// MARK: - Comparable

extension IntRepresentable where Self: Comparable {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.intValue < rhs.intValue
    }
}

// MARK: - CustomStringConvertible

extension IntRepresentable where Self: CustomStringConvertible {
    public var description: String {
        String(describing: intValue)
    }
}

// MARK: - Equatable

extension IntRepresentable where Self: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.intValue == rhs.intValue
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension IntRepresentable where Self: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(intValue: Int(integerLiteral: value))!    // swiftlint:disable:this force_unwrapping
    }
}
