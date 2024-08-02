// © 2024 John Gary Pusey (see LICENSE.md)

public protocol IntRepresentable: Codable,
                                  Comparable,
                                  CustomStringConvertible,
                                  Equatable,
                                  ExpressibleByIntegerLiteral,
                                  Hashable {
    static var invalidMessage: String { get }

    static func isValid(_ intValue: Int) -> Bool

    static func requireValid(_ intValue: Int,
                             file: StaticString,
                             line: UInt) -> Int

    init?(intValue: Int)

    init(_ intValue: Int)

    var intValue: Int { get }
}

// MARK: - (defaults)

extension IntRepresentable {
    public static var invalidMessage: String {
        "int value must be valid"
    }

    public static func isValid(_ intValue: Int) -> Bool {
        true
    }

    public static func requireValid(_ intValue: Int,
                                    file: StaticString = #file,
                                    line: UInt = #line) -> Int {
        precondition(isValid(intValue),
                     invalidMessage,
                     file: file,
                     line: line)

        return intValue
    }

    public init?(intValue: Int) {
        guard Self.isValid(intValue)
        else { return nil }

        self.init(intValue)
    }
}

// MARK: - Codable

extension IntRepresentable where Self: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let intValue = try container.decode(Int.self)

        self.init(intValue)
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
        intValue.description
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
        self.init(Int(integerLiteral: value))
    }
}
