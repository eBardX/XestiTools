// © 2026 John Gary Pusey (see LICENSE.md)

/// A type that can express its position relative to two reference values as a
/// normalized fraction.
///
/// The single required method, ``fraction(from:through:)``, expresses where
/// `self` falls relative to two reference values as a fraction in the unit
/// interval `[0, 1]`.
public protocol InterpolatableKey: Codable, Comparable, Equatable, Sendable {
    /// Normalizes `self` to the unit interval `[0, 1]`, mapping `startValue` to
    /// `0` and `endValue` to `1`.
    ///
    /// The result must be `0` when `self == startValue` and `1` when `self ==
    /// endValue`.
    ///
    /// - Parameter startValue: The reference value that maps to `0`.
    /// - Parameter endValue:   The reference value that maps to `1`.
    ///
    /// - Returns:  The normalized position of `self` relative to `startValue`
    ///             and `endValue`.
    func fraction(from startValue: Self,
                  through endValue: Self) -> Double
}

// MARK: - InterpolatableKey

extension Double: InterpolatableKey {
    public func fraction(from startValue: Double,
                         through endValue: Double) -> Double {
        (self - startValue) / (endValue - startValue)
    }
}
