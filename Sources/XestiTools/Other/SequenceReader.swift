// © 2025–2026 John Gary Pusey (see LICENSE.md)

public struct SequenceReader<S: Sequence>: Reader {

    // MARK: Public Nested Types

    public typealias Element = S.Element

    // MARK: Public Initializers

    public init(_ sequence: S) {
        self.iterator = sequence.makeIterator()
        self.next = iterator.next()
    }

    // MARK: Public Instance Properties

    public var hasMore: Bool {
        next != nil
    }

    // MARK: Public Instance Methods

    public func peek() -> Element? {
        next
    }

    public mutating func read() -> Element? {
        guard let result = next
        else { return nil }

        next = iterator.next()

        return result
    }

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
