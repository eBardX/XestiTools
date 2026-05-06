// © 2026 John Gary Pusey (see LICENSE.md)

private import Foundation

/// An interpolator that maps an input fraction to an output fraction via an
/// asymmetric logistic S-curve with independent steepness on each side of a
/// configurable center point.
///
/// The `leadingSteepness` parameter controls the curvature of the leading half
/// (before `center`) and the `trailingSteepness` parameter controls the
/// trailing half (after `center`). When both steepness values are equal and
/// `center` is `0.5`, the result is identical to ``LogisticInterpolator``.
public struct SkewedLogisticInterpolator {

    // MARK: Public Initializers

    /// Creates a new skewed logistic interpolator.
    ///
    /// - Parameter leadingSteepness:   The steepness of the logistic curve on
    ///                                 the leading side (before `center`).
    ///                                 Defaults to `10.0`.
    /// - Parameter trailingSteepness:  The steepness of the logistic curve on
    ///                                 the trailing side (after `center`).
    ///                                 Defaults to `10.0`.
    /// - Parameter center:             The input fraction at which the two
    ///                                 halves meet. Defaults to `0.5`.
    ///
    /// - Precondition: `leadingSteepness` and `trailingSteepness` must be
    ///                 finite `Double` values. `center` must be in the open
    ///                 interval `(0, 1)`.
    public init(leadingSteepness: Double = 10.0,
                trailingSteepness: Double = 10.0,
                center: Double = 0.5) {
        precondition(leadingSteepness.isFinite,
                     "leadingSteepness must be a finite Double value")

        precondition(trailingSteepness.isFinite,
                     "trailingSteepness must be a finite Double value")

        precondition(center > 0 && center < 1,
                     "center must be in the open interval (0, 1)")

        self.center = center
        self.leadingSteepness = leadingSteepness
        self.trailingSteepness = trailingSteepness
    }

    // MARK: Public Instance Properties

    /// The input fraction at which the leading and trailing halves meet.
    public let center: Double

    /// The steepness of the logistic curve on the leading side (before
    /// `center`).
    public let leadingSteepness: Double

    /// The steepness of the logistic curve on the trailing side (after
    /// `center`).
    public let trailingSteepness: Double
}

// MARK: - CustomStringConvertible

extension SkewedLogisticInterpolator: CustomStringConvertible {
    public var description: String {
        "‹skewedLogistic(leadingSteepness: \(leadingSteepness), trailingSteepness: \(trailingSteepness), center: \(center))›"
    }
}

// MARK: - Interpolator

extension SkewedLogisticInterpolator: Interpolator {

    // MARK: Public Instance Methods

    public func interpolate(_ t: Double) -> Double {
        let sigma: (Double) -> Double = { x in 1.0 / (1.0 + exp(-x)) }

        if t <= center {
            guard abs(leadingSteepness) > .ulpOfOne
            else { return t / center * 0.5 }

            let atStart = sigma(leadingSteepness * -center)

            return (sigma(leadingSteepness * (t - center)) - atStart) / (0.5 - atStart) * 0.5
        } else {
            guard abs(trailingSteepness) > .ulpOfOne
            else { return 0.5 + (t - center) / (1.0 - center) * 0.5 }

            let atEnd = sigma(trailingSteepness * (1.0 - center))

            return 0.5 + (sigma(trailingSteepness * (t - center)) - 0.5) / (atEnd - 0.5) * 0.5
        }
    }
}
