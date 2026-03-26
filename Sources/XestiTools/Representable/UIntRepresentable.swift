// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A type that can be represented by an unsigned integer value.
///
/// With a `UIntRepresentable` type, you can losslessly convert back and forth
/// between a custom type and an unsigned integer value.
///
/// In addition, you can restrict the unsigned integer values that are
/// considered valid representations of your custom type.
///
/// Using the unsigned integer value of a conforming type simplifies conformance
/// to other protocols, such as `Codable`, `Comparable`, and `Hashable`.
public protocol UIntRepresentable: Codable,
                                   Comparable,
                                   CustomStringConvertible,
                                   Equatable,
                                   ExpressibleByIntegerLiteral,
                                   Hashable,
                                   Sendable {
    /// Determines if an unsigned integer value is a valid representation for
    /// this type.
    ///
    /// The default implementation considers _any_ unsigned integer value to be
    /// valid.
    ///
    /// - Parameter uintValue:  The unsigned integer value to check for
    ///                         validity.
    ///
    /// - Returns:  `true` if the provided unsigned integer value is a valid
    ///             representation for this type; `false` otherwise.
    static func isValid(_ uintValue: UInt) -> Bool

    /// Creates a new instance with the provided unsigned integer value.
    ///
    /// If the provided unsigned integer value is determined to be invalid, this
    /// initializer stops execution.
    ///
    /// The default implementation is sufficient in most cases.
    ///
    /// - Parameter uintValue:  The unsigned integer value to use for the new
    ///                         instance.
    init(_ uintValue: UInt)

    /// Creates a new instance with the provided unsigned integer value.
    ///
    /// If the provided unsigned integer value is determined to be invalid, this
    /// initializer returns `nil`.
    /// 
    /// Typically, this initializer can be implemented as follows:
    ///
    /// ```swift
    /// public init?(uintValue: UInt) {
    ///     guard Self.isValid(uintValue)
    ///     else { return nil }
    ///
    ///     self.uintValue = uintValue
    /// }
    /// ```
    ///
    /// - Parameter uintValue:  The unsigned integer value to use for the new
    ///                         instance.
    init?(uintValue: UInt)

    /// The unsigned integer value that represents this type.
    ///
    /// A new instance initialized with `uintValue` will be equivalent to this
    /// instance.
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

        guard let value = Self(uintValue: uintValue)
        else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath,
                                                                       debugDescription: "Invalid uint value: \(uintValue)")) }

        self = value
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
        String(uintValue)
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
