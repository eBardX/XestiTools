// © 2026 John Gary Pusey (see LICENSE.md)

/// A type that can produce an interpolated value between two reference values
/// at a given normalized fraction.
///
/// The single required method, ``value(of:from:through:)``, maps a fraction in
/// the unit interval `[0, 1]` to a value between two reference values.
public protocol InterpolatableValue: Codable, Equatable, Sendable {
    /// Returns the value at `fraction` between `startValue` and `endValue`.
    ///
    /// The result must equal `startValue` when `fraction == 0` and `endValue`
    /// when `fraction == 1`.
    ///
    /// - Parameter fraction:   A position in the unit interval `[0, 1]`, where
    ///                         `0` corresponds to `startValue` and `1` to
    ///                         `endValue`.
    /// - Parameter startValue: The value that maps to a fraction of `0`.
    /// - Parameter endValue:   The value that maps to a fraction of `1`.
    ///
    /// - Returns:  The interpolated value at `fraction`.
    static func value(of fraction: Double,
                      from startValue: Self,
                      through endValue: Self) -> Self
}

// MARK: - InterpolatableValue

extension Double: InterpolatableValue {
    public static func value(of fraction: Double,
                             from startValue: Double,
                             through endValue: Double) -> Double {
        startValue + (endValue - startValue) * fraction
    }
}
