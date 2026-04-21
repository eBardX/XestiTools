// © 2026 John Gary Pusey (see LICENSE.md)

extension Double {

    // MARK: Public Instance Methods

    /// Determines the rational fraction that is the nearest approximation to
    /// this value and returns it.
    ///
    /// The result is computed using the continued-fraction algorithm and is
    /// accurate to six decimal places.
    ///
    /// - Returns:  A tuple containing the `numerator` and `denominator` of the
    ///             nearest rational approximation to this value.
    ///
    /// - Precondition: This value must be finite (not `nan` or `infinity`).
    @available(*, deprecated, renamed: "rationalized()")
    public func asFraction() -> (numerator: Int, denominator: Int) {
        rationalized()
    }

    /// Determines the rational fraction that is the nearest approximation to
    /// this value and returns it.
    ///
    /// The result is computed using the continued-fraction algorithm and is
    /// accurate to six decimal places.
    ///
    /// - Returns:  A tuple containing the `numerator` and `denominator` of the
    ///             nearest rational approximation to this value.
    ///
    /// - Precondition: This value must be finite (not `nan` or `infinity`).
    public func rationalized() -> (numerator: Int, denominator: Int) {
        //
        // Adapted from https://github.com/kevinboone/rationalize
        //
        precondition(isFinite,
                     "Double value must be finite")

        let (xmag, xneg) = self < 0 ? (-self, true) : (self, false)
        let origValue = Int(xmag * Double(Self.scale))

        var (value, cfCoef) = (origValue, origValue / Self.scale)
        var (num, prevNum) = (cfCoef, 1)
        var (den, prevDen) = (1, 0)

        var loopCount = 0

        while loopCount < Self.order && (value - (cfCoef * Self.scale)) != 0 {
            value = (Self.scale * Self.scale) / (value - (cfCoef * Self.scale))
            cfCoef = value / Self.scale

            (num, prevNum) = (prevNum + cfCoef * num, num)
            (den, prevDen) = (prevDen + cfCoef * den, den)

            guard den != 0,
                  abs(((num * Self.scale) / den) - origValue) > 1
            else { break }

            loopCount += 1
        }

        if xneg {
            num = -num
        }

        return (num, den)
    }

    // MARK: Private Type Properties

    private static let order = 6
    private static let scale = 1_000_000    // 10^order
}
