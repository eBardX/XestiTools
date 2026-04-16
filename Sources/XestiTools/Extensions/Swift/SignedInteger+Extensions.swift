// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension SignedInteger {

    // MARK: Public Instance Methods

    /// Returns the mathematical modulo of this value and `m`.
    ///
    /// Unlike the `%` operator, which returns a remainder with the sign of the
    /// dividend, this method always returns a non-negative result when `m` is
    /// positive.
    ///
    /// - Parameter m:  The divisor.
    ///
    /// - Returns:  The value of `self` modulo `m`.
    public func modulo(_ m: Self) -> Self {
        let rem = self % m

        return rem != 0 && (self ^ m) < 0 ? rem + m : rem
    }
}
