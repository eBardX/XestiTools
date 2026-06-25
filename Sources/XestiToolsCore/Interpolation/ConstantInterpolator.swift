/// An interpolator that maps every input fraction to an output fraction of `0`,
/// holding the start value for the entire segment.
///
/// No blending occurs — the output is always `0` regardless of the input
/// fraction, so every point in the segment maps to the start value. The end
/// value is never reached.
public struct ConstantInterpolator {

    // MARK: Public Initializers

    /// Creates a new constant interpolator.
    public init() {
    }
}

// MARK: - CustomStringConvertible

 extension ConstantInterpolator: CustomStringConvertible {
    public var description: String {
        "‹constant›"
    }
 }

// MARK: - Interpolator

extension ConstantInterpolator: Interpolator {

    // MARK: Public Instance Methods

    public func interpolate(_ value: Double) -> Double {
        0
    }
}
