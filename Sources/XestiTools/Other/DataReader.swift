import Foundation

public struct DataReader {

    // MARK: Public Initializers

    public init(_ data: Data) {
        self.data = data
        self.index = data.startIndex
    }

    // MARK: Public Instance Properties

    public var hasMore: Bool {
        index < data.endIndex
    }

    // MARK: Public Instance Methods

    public func peek() -> UInt8? {
        guard index < data.endIndex
        else { return nil }

        return data[index]
    }

    public mutating func read() -> UInt8? {
        guard index < data.endIndex
        else { return nil }

        defer { data.formIndex(after: &index) }

        return data[index]
    }

    @discardableResult
    public mutating func skip() -> Bool {
        guard index < data.endIndex
        else { return false }

        data.formIndex(after: &index)

        return true
    }

    // MARK: Private Instance Properties

    private let data: Data

    private var index: Data.Index
}
