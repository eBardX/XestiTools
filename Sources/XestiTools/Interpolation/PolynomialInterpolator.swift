private import Foundation

/// An interpolator that maps an input fraction to an output fraction via power
/// curve acceleration.
///
/// When `power > 1`, this interpolator produces acceleration (slow start, fast
/// finish) — `power == 2` is quadratic, `power == 3` is cubic, and so on. When
/// `power` is between `0` and `1`, this interpolator produces deceleration
/// (fast start, slow finish). A `power` of `1` is equivalent to
/// ``LinearInterpolator``.
public struct PolynomialInterpolator {

    // MARK: Public Initializers

    /// Creates a new polynomial interpolator.
    ///
    /// - Parameter power:  The exponent of the power curve.
    ///
    /// - Precondition: `power` must be a positive finite `Double` value.
    public init(power: Double) {
        precondition(power.isFinite && power > 0,
                     "power must be a positive finite Double value")

        self.power = power
    }

    // MARK: Public Instance Properties

    /// The exponent of the power curve.
    public let power: Double
}

// MARK: - CustomStringConvertible

 extension PolynomialInterpolator: CustomStringConvertible {
    public var description: String {
        "‹polynomial(power: \(power))›"
    }
 }

// MARK: - Interpolator

extension PolynomialInterpolator: Interpolator {

    // MARK: Public Instance Methods

    public func interpolate(_ value: Double) -> Double {
        pow(value, power)
    }
}
