// © 2026 John Gary Pusey (see LICENSE.md)

/// A type that can be represented by a floating-point value.
///
/// With an `FloatRepresentable` type, you can losslessly convert back and forth
/// between a custom type and a floating-point value.
///
/// In addition, you can restrict the floating-point values that are considered
/// valid representations of your custom type.
///
/// Using the floating-point value of a conforming type simplifies conformance
/// to other protocols, such as `Codable`, `Comparable`, and `Hashable`.
public protocol FloatRepresentable: Codable,
                                    Comparable,
                                    CustomStringConvertible,
                                    Equatable,
                                    ExpressibleByFloatLiteral,
                                    ExpressibleByIntegerLiteral,
                                    Hashable,
                                    Sendable {
    /// Determines if the provided floating-point value is a valid
    /// representation for this type.
    ///
    /// The default implementation considers _any_ floating-point value to be
    /// valid.
    ///
    /// - Parameter doubleValue:    The floating-point value to check for
    ///                             validity.
    ///
    /// - Returns:  `true` if the provided floating-point value is a valid
    ///             representation for this type; `false` otherwise.
    static func isValid(_ doubleValue: Double) -> Bool

    /// Creates a new instance with the provided floating-point value.
    ///
    /// If the provided floating-point value is determined to be invalid, this
    /// initializer stops execution.
    ///
    /// The default implementation is sufficient in most cases.
    ///
    /// - Parameter doubleValue:    The floating-point value to use for the new
    ///                             instance.
    init(_ doubleValue: Double)

    /// Creates a new instance with the provided floating-point value.
    ///
    /// If the provided floating-point value is determined to be invalid, this
    /// initializer returns `nil`.
    ///
    /// Typically, this initializer can be implemented as follows:
    ///
    /// ```swift
    /// public init?(doubleValue: Double) {
    ///     guard Self.isValid(doubleValue)
    ///     else { return nil }
    ///
    ///     self.doubleValue = doubleValue
    /// }
    /// ```
    ///
    /// - Parameter doubleValue:    The floating-point value to use for the new
    ///                             instance.
    init?(doubleValue: Double)

    /// The floating-point value that represents this type.
    ///
    /// A new instance initialized with `doubleValue` will be equivalent to this
    /// instance.
    var doubleValue: Double { get }
}

// MARK: - (defaults)

extension FloatRepresentable {
    public static func isValid(_ doubleValue: Double) -> Bool {
        true
    }

    public init(_ doubleValue: Double) {
        self.init(doubleValue: doubleValue)!    // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Codable

extension FloatRepresentable where Self: Codable {
    /// Creates an instance by decoding from the provided decoder.
    ///
    /// - Throws:   A `DecodingError` if decoding fails.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let doubleValue = try container.decode(Double.self)

        guard let value = Self(doubleValue: doubleValue)
        else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath,
                                                                       debugDescription: "Invalid double value: \(doubleValue)")) }

        self = value
    }

    /// Encodes this instance into the provided encoder.
    ///
    /// - Throws:   An `EncodingError` if encoding fails.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(doubleValue)
    }
}

// MARK: - Comparable

extension FloatRepresentable where Self: Comparable {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.doubleValue < rhs.doubleValue
    }
}

// MARK: - CustomStringConvertible

extension FloatRepresentable where Self: CustomStringConvertible {
    public var description: String {
        String(doubleValue)
    }
}

// MARK: - Equatable

extension FloatRepresentable where Self: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.doubleValue == rhs.doubleValue
    }
}

// MARK: - ExpressibleByFloatLiteral

extension FloatRepresentable where Self: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(doubleValue: value)!  // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension FloatRepresentable where Self: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Double) {
        self.init(doubleValue: value)!  // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Hashable

extension FloatRepresentable where Self: Hashable {
    public func hash(into hasher: inout Hasher) {
        doubleValue.hash(into: &hasher)
    }
}
