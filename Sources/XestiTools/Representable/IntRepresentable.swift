// © 2024–2026 John Gary Pusey (see LICENSE.md)

/// A type that can be represented by an integer value.
///
/// With an `IntRepresentable` type, you can losslessly convert back and forth
/// between a custom type and an integer value.
///
/// In addition, you can restrict the integer values that are considered valid
/// representations of your custom type.
///
/// Using the integer value of a conforming type simplifies conformance to other
/// protocols, such as `Codable`, `Comparable`, and `Hashable`.
public protocol IntRepresentable: Codable,
                                  Comparable,
                                  CustomStringConvertible,
                                  Equatable,
                                  ExpressibleByIntegerLiteral,
                                  Hashable,
                                  Sendable {
    /// Determines if the provided integer value is a valid representation for
    /// this type.
    ///
    /// The default implementation considers _any_ integer value to be valid.
    ///
    /// - Parameter intValue:   The integer value to check for validity.
    ///
    /// - Returns:  `true` if the provided integer value is a valid
    ///             representation for this type; `false` otherwise.
    static func isValid(_ intValue: Int) -> Bool

    /// Creates a new instance with the provided integer value.
    ///
    /// If the provided integer value is determined to be invalid, this
    /// initializer stops execution.
    ///
    /// The default implementation is sufficient in most cases.
    ///
    /// - Parameter intValue:   The integer value to use for the new instance.
    init(_ intValue: Int)

    /// Creates a new instance with the provided integer value.
    ///
    /// If the provided integer value is determined to be invalid, this
    /// initializer returns `nil`.
    ///
    /// Typically, this initializer can be implemented as follows:
    ///
    /// ```swift
    /// public init?(intValue: String) {
    ///     guard Self.isValid(intValue)
    ///     else { return nil }
    ///
    ///     self.intValue = intValue
    /// }
    /// ```
    ///
    /// - Parameter intValue:   The integer value to use for the new instance.
    init?(intValue: Int)

    /// The integer value that represents this type.
    ///
    /// A new instance initialized with `intValue` will be equivalent to this
    /// instance.
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
