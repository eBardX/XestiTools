// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A reader that traverses the elements of the provided sequence.
public struct SequenceReader<S: Sequence>: Reader {

    // MARK: Public Nested Types

    /// The type of element traversed by the sequence reader.
    public typealias Element = S.Element

    // MARK: Public Initializers

    /// Creates a new, _single-use_ sequence reader.
    ///
    /// - Parameter sequence:   The sequence from which to read elements. 
    public init(_ sequence: S) {
        self.iterator = sequence.makeIterator()
        self.next = iterator.next()
    }

    // MARK: Public Instance Properties

    /// A Boolean value indicating whether there are more elements available in
    /// the sequence.
    public var hasMore: Bool {
        next != nil
    }

    // MARK: Public Instance Methods

    /// Returns the next element from the sequence without removing it.
    ///
    /// - Returns:  The next element from the sequence, if a next element
    ///             exists; otherwise, `nil`.
    public func peek() -> Element? {
        next
    }

    /// Removes the next element from the sequence and returns it.
    ///
    /// - Returns:  The next element from the sequence, if a next element
    ///             exists; otherwise, `nil`.
    public mutating func read() -> Element? {
        guard let result = next
        else { return nil }

        next = iterator.next()

        return result
    }

    /// Removes and discards the next element from the sequence.
    ///
    /// - Returns:  `true` if a next element exists; otherwise, `false`.
    @discardableResult
    public mutating func skip() -> Bool {
        guard next != nil
        else { return false }

        next = iterator.next()

        return true
    }

    // MARK: Private Instance Properties

    private var iterator: S.Iterator
    private var next: Element?
}
