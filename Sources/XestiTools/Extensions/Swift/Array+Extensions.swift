// © 2023–2026 John Gary Pusey (see LICENSE.md)

extension Array {
    /// Removes and returns the last element of this array.
    ///
    /// - Returns:  The last element of this array, or `nil` if this array is
    ///             empty.
    public mutating func pop() -> Element? {
        guard !isEmpty
        else { return nil }

        return removeLast()
    }

    /// Adds an element to the end of this array.
    ///
    /// - Parameter elt:    The element to add to the end of this array.
    public mutating func push(_ elt: Element) {
        append(elt)
    }

    /// Returns the last element of this array.
    ///
    /// - Returns:  The last element of this array, or `nil` if this array is
    ///             empty.
    public func top() -> Element? {
        last
    }
}
