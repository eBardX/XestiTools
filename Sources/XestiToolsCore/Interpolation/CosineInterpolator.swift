private import Foundation

/// An interpolator that maps an input fraction to an output fraction via a
/// cosine S-curve.
///
/// This interpolator produces a slow start and slow finish with smooth
/// acceleration through the middle — equivalent to `(1 - cos(π·t)) / 2`, with a
/// zero derivative at both endpoints.
public struct CosineInterpolator {

    // MARK: Public Initializers

    /// Creates a new cosine interpolator.
    public init() {
    }
}

// MARK: - CustomStringConvertible

 extension CosineInterpolator: CustomStringConvertible {
    public var description: String {
        "‹cosine›"
    }
 }

// MARK: - Interpolator

extension CosineInterpolator: Interpolator {

    // MARK: Public Instance Methods

    public func interpolate(_ value: Double) -> Double {
        (1 - cos(.pi * value)) / 2
    }
}
