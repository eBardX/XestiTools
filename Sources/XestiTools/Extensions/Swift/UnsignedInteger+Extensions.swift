// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension UnsignedInteger {

    // MARK: Public Type Methods

    /// Returns the greatest common divisor of two values.
    ///
    /// - Parameter n1: The first value.
    /// - Parameter n2: The second value.
    ///
    /// - Returns:  The greatest common divisor of `n1` and `n2`, or `n1` if
    ///             `n2` is zero.
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
