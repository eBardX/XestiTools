// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension UnsignedInteger {

    // MARK: Public Type Methods

	/// Calculates the greatest common divisor of the two provided unsigned
	/// integers and returns the result.
    ///
    /// - Parameter n1: The first unsigned integer for which to calculate the
    ///                 greatest common divisor.
    /// - Parameter n2: The second unsigned integer for which to calculate the
    ///                 greatest common divisor.
    ///
    /// - Returns:  The result of the greatest common divisor calculation.
    public static func gcd(_ n1: Self,
                           _ n2: Self) -> Self {
        var val1 = n1
        var val2 = n2

        while val2 != 0 {
            (val1, val2) = (val2, val1 % val2)
        }

        return val1
    }
}
