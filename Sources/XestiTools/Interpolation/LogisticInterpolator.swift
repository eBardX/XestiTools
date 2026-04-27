// © 2026 John Gary Pusey (see LICENSE.md)

private import Foundation

/// An interpolator that maps an input fraction to an output fraction via a
/// logistic S-curve.
///
/// When `steepness > 0`, the curve eases in and out (slow-fast-slow); larger
/// values sharpen the transition near the midpoint. When `steepness < 0`, the
/// curve is the analytical inverse (fast-slow-fast). When `steepness = 0`, the
/// output equals the input (linear).
public struct LogisticInterpolator {

    // MARK: Public Initializers

    /// Creates a new logistic interpolator.
    ///
    /// - Parameter steepness:  The steepness of the logistic curve. Defaults to
    ///                         `10.0`.
    ///
    /// - Precondition: `steepness` must be a finite `Double` value.
    public init(steepness: Double = 10.0) {
        precondition(steepness.isFinite,
                     "steepness must be a finite Double value")

        self.steepness = steepness
    }

    // MARK: Public Instance Properties

    /// The steepness of the logistic curve.
    public let steepness: Double
}

// MARK: - CustomStringConvertible

extension LogisticInterpolator: CustomStringConvertible {
    public var description: String {
        "‹logistic(steepness: \(steepness))›"
    }
}

// MARK: - Interpolator

extension LogisticInterpolator: Interpolator {

    // MARK: Public Instance Methods

    public func interpolate(_ t: Double) -> Double {
        guard abs(steepness) > .ulpOfOne
        else { return t }

        let sigma: (Double) -> Double = { x in 1.0 / (1.0 + exp(-x)) }
        let absSteepness = abs(steepness)
        let atZero = sigma(-absSteepness / 2.0)
        let atOne  = sigma( absSteepness / 2.0)

        if steepness > 0 {
            return (sigma(absSteepness * (t - 0.5)) - atZero) / (atOne - atZero)
        }

        let y = t * (atOne - atZero) + atZero

        return 0.5 - log(1.0 / y - 1.0) / absSteepness
    }
}
