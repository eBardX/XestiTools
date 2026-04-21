private import Foundation

/// An interpolator that maps an input fraction to an output fraction via
/// exponential acceleration or deceleration.
///
/// When `base > 1`, this interpolator produces acceleration (slow start, fast
/// finish); when `base < 1`, it produces deceleration (fast start, slow
/// finish). Higher `power` values steepen the curve; larger `base` values widen
/// the dynamic range.
public struct ExponentialInterpolator {

    // MARK: Public Initializers

    /// Creates a new exponential interpolator.
    ///
    /// - Parameter base:   The base of the exponential curve.
    /// - Parameter power:  The exponent scaling factor.
    ///
    /// - Precondition: Both `base` and `power` must be positive finite `Double`
    ///                 values.
    public init(base: Double,
                power: Double) {
        precondition(base.isFinite && base > 0,
                     "base must be a positive finite Double value")

        precondition(power.isFinite && power > 0,
                     "power must be a positive finite Double value")

        self.base = base
        self.power = power
    }

    // MARK: Public Instance Properties

    /// The base of the exponential curve.
    public let base: Double

    /// The exponent scaling factor.
    public let power: Double
}

// MARK: - CustomStringConvertible

extension ExponentialInterpolator: CustomStringConvertible {
    public var description: String {
        "‹exponential(base: \(base), power: \(power))›"
    }
}

// MARK: - Interpolator

extension ExponentialInterpolator: Interpolator {

    // MARK: Public Instance Methods

    public func interpolate(_ value: Double) -> Double {
        ((pow(base, value * power) - 1) /
         (pow(base, power) - 1))
    }
}
