// © 2025 John Gary Pusey (see LICENSE.md)

public struct SequenceReader<Base: Sequence>: Reader {

    // MARK: Public Initializers

    public init(_ base: Base) {
        self.iterator = base.makeIterator()
        self.next = iterator.next()
    }

    // MARK: Public Instance Properties

    public var hasMore: Bool {
        next != nil
    }

    // MARK: Public Instance Methods

    public func peek() -> Base.Element? {
        next
    }

    public mutating func read() -> Base.Element? {
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

    private var iterator: Base.Iterator
    private var next: Base.Element?
}
