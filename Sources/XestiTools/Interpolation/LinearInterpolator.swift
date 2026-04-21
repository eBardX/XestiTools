/// An interpolator that maps an input fraction to an output fraction at a
/// uniform rate.
///
/// The output fraction equals the input fraction — no acceleration or
/// deceleration.
public struct LinearInterpolator {

    // MARK: Public Initializers

    /// Creates a new linear interpolator.
    public init() {
    }
}

// MARK: - CustomStringConvertible

 extension LinearInterpolator: CustomStringConvertible {
    public var description: String {
        "‹linear›"
    }
 }

// MARK: - Interpolator

extension LinearInterpolator: Interpolator {

    // MARK: Public Instance Methods

    public func interpolate(_ value: Double) -> Double {
        value
    }
}
