private import Foundation

/// An interpolator that maps an input fraction to an output fraction via
/// logarithmic deceleration.
///
/// This interpolator always produces deceleration (fast start, slow finish): it
/// rises quickly near `0` and flattens as it approaches `1`. Larger `base`
/// values produce a more pronounced initial burst followed by a longer plateau.
public struct LogarithmicInterpolator {

    // MARK: Public Initializers

    /// Creates a new logarithmic interpolator.
    ///
    /// - Parameter base:	The base of the logarithm.
    ///
    /// - Precondition:	`base` must be a positive finite `Double` value.
    public init(base: Double) {
        precondition(base.isFinite && base > 0,
                     "base must be a positive finite Double value")

        self.base = base
    }

    // MARK: Public Instance Properties

    /// The base of the logarithm.
    public let base: Double
}

// MARK: - CustomStringConvertible

 extension LogarithmicInterpolator: CustomStringConvertible {
    public var description: String {
        "‹logarithmic(base: \(base))›"
    }
 }

// MARK: - Interpolator

extension LogarithmicInterpolator: Interpolator {

    // MARK: Public Instance Methods

    public func interpolate(_ value: Double) -> Double {
        log(1 + (value * (base - 1))) / log(base)
    }
}
