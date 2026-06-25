// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A type that traverses the elements of an arbitrary source.
public protocol Reader<Element> {
    /// The type of element traversed by the reader.
    associatedtype Element

    /// A Boolean value indicating whether there are more elements available in
    /// the source.
    var hasMore: Bool { get }

    /// Returns the next element from the source without removing it.
    ///
    /// - Returns:  The next element from the source, if a next element exists;
    ///             otherwise, `nil`.
    func peek() -> Element?

    /// Removes the next element from the source and returns it.
    ///
    /// - Returns:  The next element from the source, if a next element exists;
    ///             otherwise, `nil`.
    mutating func read() -> Element?

    /// Removes and discards the next element from the source.
    ///
    /// - Returns:  `true` if a next element exists; otherwise, `false`.
    @discardableResult
    mutating func skip() -> Bool
}
