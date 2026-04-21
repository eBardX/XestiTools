/// A type that maps an input fraction to an output fraction.
///
/// An interpolator takes an *input fraction* in the unit interval `[0, 1]` —
/// typically produced by ``InterpolatableKey/fraction(from:through:)`` — and
/// maps it to an *output fraction* in the unit interval suitable for passing to
/// ``InterpolatableValue/value(of:from:through:)``. This indirection allows you
/// to control the rate of change between two reference values independently of
/// the key and value types — producing a variety of transitions, for example,
/// linear, accelerating, decelerating, or instantaneous.
///
/// Built-in conformances to this type include:
///
/// - ``LinearInterpolator`` — uniform rate (output tracks input directly)
/// - ``ConstantInterpolator`` — constant (holds the start value; no blending)
/// - ``PolynomialInterpolator`` — power curve acceleration
/// - ``ExponentialInterpolator`` — exponential acceleration (or deceleration
///   when `base < 1`)
/// - ``LogarithmicInterpolator`` — logarithmic deceleration
/// - ``CosineInterpolator`` — cosine S-curve (slow start, slow finish)
public protocol Interpolator: Codable,
                              Equatable,
                              Hashable,
                              Sendable {
    /// The unchecked interpolation function that performs the actual mapping
    /// from an input fraction to an output fraction.
    ///
    /// Callers should use ``checkedInterpolate(_:)`` instead, which enforces
    /// that both the input fraction and output fraction are in the unit
    /// interval. Implement this method to define the interpolation function;
    /// range validation is handled by ``checkedInterpolate(_:)``.
    ///
    /// - Parameter value:  The input fraction — a value in the unit interval
    ///                     `[0, 1]`.
    /// 
    /// - Returns:  The output fraction — the mapped result value in the unit
    ///             interval `[0, 1]`.
    func interpolate(_ value: Double) -> Double
}

// MARK: -

extension Interpolator {
    /// Applies ``interpolate(_:)`` with bounds checking on both input and output.
    ///
    /// This is the recommended way to invoke an interpolator. It catches both
    /// invalid input values and buggy ``interpolate(_:)`` implementations that
    /// return out-of-range output values.
    ///
    /// - Parameter value:  The input fraction — a value in the unit interval
    ///                     `[0, 1]`.
    ///
    /// - Returns:  The output fraction — the mapped result value in the unit
    ///             interval `[0, 1]`.
    ///
    /// - Precondition: `value` must be a finite `Double` value in the unit
    ///                 interval `[0, 1]`.`
    /// 
    /// - Postcondition:    `interpolate(_:)` must return a finite `Double`
    ///                     value in the unit interval `[0, 1]`.
    public func checkedInterpolate(_ value: Double) -> Double {
        precondition(value.isFinite && (0...1) ~= value,
                     "value must be a finite Double value in the unit interval [0, 1]")

        let result = interpolate(value)

        precondition(result.isFinite && (0...1) ~= result,
                     "interpolate(_:) must return a finite Double value in the unit interval [0, 1]")

        return result
    }
}
