// © 2023–2026 John Gary Pusey (see LICENSE.md)

extension Optional {
    /// Unconditionally unwraps this instance and returns the wrapped value.
    ///
    /// If this instance is `nil`, this method prints the provided hint and
    /// stops execution.
    ///
    /// - Parameter hint:   The string to print if execution is stopped. If the
    ///                     hint is `nil`, a generic hint is used. Defaults to
    ///                     `nil`.
    /// - Parameter file:   The file name to print along with `hint` if
    ///                     execution is stopped. Defaults to the file where
    ///                     this method is called.
    /// - Parameter line:   The line number to print along with `hint` if
    ///                     execution is stopped. Defaults to the line number
    ///                     where this method is called.
    ///
    /// - Returns:  The wrapped value of this instance.
    public func require(hint: @autoclosure () -> String? = nil,
                        file: StaticString = #file,
                        line: UInt = #line) -> Wrapped {
        guard let unwrapped = self
        else { fatalError(hint() ?? "Missing required value",
                          file: file,
                          line: line) }

        return unwrapped
    }
}

extension Optional where Wrapped: Equatable {
    /// Returns `nil` if the wrapped value of this instance is equal to the
    /// provided value.
    ///
    /// - Parameter value:  The value to compare to the wrapped value of this
    ///                     instance.
    ///
    /// - Returns:  `nil` if the values match, otherwise this instance.
    public func nilIfEqual(to value: Wrapped) -> Wrapped? {
        guard let unwrapped = self,
              unwrapped != value
        else { return nil }

        return self
    }
}
