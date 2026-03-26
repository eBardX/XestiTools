// © 2023–2026 John Gary Pusey (see LICENSE.md)

/// A type that can be represented by a string value.
///
/// With a `StringRepresentable` type, you can losslessly convert back and forth
/// between a custom type and a string value.
///
/// In addition, you can restrict the string values that are considered valid
/// representations of your custom type.
///
/// Using the string value of a conforming type simplifies conformance to other
/// protocols, such as `Codable`, `Comparable`, and `Hashable`.
public protocol StringRepresentable: Codable,
                                     Comparable,
                                     CustomStringConvertible,
                                     Equatable,
                                     ExpressibleByStringLiteral,
                                     Hashable,
                                     Sendable {
    /// Determines if the provided string value is a valid representation for
    /// this type.
    ///
    /// The default implementation considers any _non-empty_ string value to be
    /// valid.
    ///
    /// - Parameter stringValue:    The string value to check for validity.
    ///
    /// - Returns:  `true` if the provided string value is a valid
    ///             representation for this type; `false` otherwise.
    static func isValid(_ stringValue: String) -> Bool

    /// Creates a new instance with the provided string value.
    ///
    /// If the provided string value is determined to be invalid, this
    /// initializer stops execution.
    ///
    /// The default implementation is sufficient in most cases.
    ///
    /// - Parameter stringValue:    The string value to use for the new
    ///                             instance.
    init(_ stringValue: String)

    /// Creates a new instance with the provided string value.
    ///
    /// If the provided string value is determined to be invalid, this
    /// initializer returns `nil`.
    ///
    /// Typically, this initializer can be implemented as follows:
    ///
    /// ```swift
    /// public init?(stringValue: String) {
    ///     guard Self.isValid(stringValue)
    ///     else { return nil }
    ///
    ///     self.stringValue = stringValue
    /// }
    /// ```
    ///
    /// - Parameter stringValue:    The string value to use for the new
    ///                             instance.
    init?(stringValue: String)

    /// The string value that represents this type.
    ///
    /// A new instance initialized with `stringValue` will be equivalent to this
    /// instance.
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

        guard let value = Self(stringValue: stringValue)
        else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath,
                                                                       debugDescription: "Invalid string value: \(stringValue)")) }

        self = value
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
        stringValue
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
