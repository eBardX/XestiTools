// © 2023–2026 John Gary Pusey (see LICENSE.md)

extension Dictionary {

    // MARK: Public Instance Methods

    /// Returns a new dictionary containing only the key-value pairs that have
    /// non-`nil` keys as the result of transformation by the given closure.
    ///
    /// - Parameter transform:  A closure that transforms a key. `transform`
    ///                         accepts each key of the dictionary as its
    ///                         parameter and returns an optional transformed
    ///                         key of the same or of a different type.
    ///
    /// - Returns:  A dictionary containing the values and non-`nil`
    ///             transformed keys of this dictionary.
    public func compactMapKeys<T>(_ transform: (Key) throws -> T?) rethrows -> [T: Value] {
        try reduce(into: [T: Value]()) { result, element in
            if let key = try transform(element.key) {
                result[key] = element.value
            }
        }
    }

    /// Returns a new dictionary containing the values of this dictionary with
    /// the keys transformed by the given closure.
    ///
    /// - Parameter transform:  A closure that transforms a key. `transform`
    ///                         accepts each key of the dictionary as its
    ///                         parameter and returns a transformed key of the
    ///                         same or of a different type.
    ///
    /// - Returns:  A dictionary containing the values and transformed keys of
    ///             this dictionary.
    public func mapKeys<T>(_ transform: (Key) throws -> T) rethrows -> [T: Value] {
        try reduce(into: [T: Value]()) { result, element in
            result[try transform(element.key)] = element.value
        }
    }
}
