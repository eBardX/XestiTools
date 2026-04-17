// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension SignedInteger {

    // MARK: Public Instance Methods

	/// Calculates the modulo of this integer divided by the provided integer
	/// and returns the result.
    ///
    /// - Parameter m:  The integer _modulus_ by which to divide this integer.
    ///
    /// - Returns:  The result of the modulo calculation.
    ///
    /// - Precondition: `m` must not be zero.
    public func modulo(_ m: Self) -> Self {
        let rem = self % m

        return rem != 0 && (self ^ m) < 0 ? rem + m : rem
    }
}
