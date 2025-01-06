// © 2025 John Gary Pusey (see LICENSE.md)

public struct CollectionReader<Base: BidirectionalCollection> {

    // MARK: Public Initializers

    public init(_ base: Base) {
        self.base = base
        self.currentIndex = base.startIndex
        self.savedIndex = base.startIndex
    }

    // MARK: Public Instance Properties

    public var hasMore: Bool {
        currentIndex < base.endIndex
    }

    // MARK: Public Instance Methods

    public mutating func mark() {
        savedIndex = currentIndex
    }

    public func peek() -> Base.Element? {
        guard currentIndex < base.endIndex
        else { return nil }

        return base[currentIndex]
    }

    public mutating func read() -> Base.Element? {
        guard currentIndex < base.endIndex
        else { return nil }

        defer { base.formIndex(after: &currentIndex) }

        return base[currentIndex]
    }

    public mutating func reset() {
        currentIndex = savedIndex
    }

    @discardableResult
    public mutating func skipToNext() -> Bool {
        guard currentIndex < base.endIndex
        else { return false }

        base.formIndex(after: &currentIndex)

        return true
    }

    @discardableResult
    public mutating func skipToPrevious() -> Bool {
        guard currentIndex > base.startIndex
        else { return false }

        base.formIndex(before: &currentIndex)

        return true
    }

    // MARK: Private Instance Properties

    private let base: Base

    private var currentIndex: Base.Index
    private var savedIndex: Base.Index
}
