// © 2025 John Gary Pusey (see LICENSE.md)

public struct AsyncSequenceReader<Base: AsyncSequence>: AsyncReader {

    // MARK: Public Initializers

    public init(_ base: Base) async throws {
        self.iterator = base.makeAsyncIterator()
        self.next = try await iterator.next()
    }

    // MARK: Public Instance Properties

    public var hasMore: Bool {
        next != nil
    }

    // MARK: Public Instance Methods

    public func peek() async throws -> Base.Element? {
        next
    }

    public mutating func read() async throws -> Base.Element? {
        guard let result = next
        else { return nil }

        next = try await iterator.next()

        return result
    }

    @discardableResult
    public mutating func skip() async throws -> Bool {
        guard next != nil
        else { return false }

        next = try await iterator.next()

        return true
    }

    // MARK: Private Instance Properties

    private var iterator: Base.AsyncIterator
    private var next: Base.Element?
}
