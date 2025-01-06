// © 2024–2025 John Gary Pusey (see LICENSE.md)

@available(*, deprecated, message: "Use CollectionReader<String>")
public struct StringReader {

    // MARK: Public Initializers

    public init(_ string: String) {
        self.index = string.startIndex
        self.string = string
    }

    // MARK: Public Instance Properties

    public var hasMore: Bool {
        index < string.endIndex
    }

    // MARK: Public Instance Methods

    public func peek() -> Character? {
        guard index < string.endIndex
        else { return nil }

        return string[index]
    }

    public mutating func read() -> Character? {
        guard index < string.endIndex
        else { return nil }

        defer { string.formIndex(after: &index) }

        return string[index]
    }

    @discardableResult
    public mutating func skip() -> Bool {
        guard index < string.endIndex
        else { return false }

        string.formIndex(after: &index)

        return true
    }

    // MARK: Private Instance Properties

    private let string: String

    private var index: String.Index
}
