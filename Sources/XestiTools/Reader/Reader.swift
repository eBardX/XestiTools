// © 2025 John Gary Pusey (see LICENSE.md)

public protocol Reader<Element> {
    associatedtype Element

    var hasMore: Bool { get }

    func peek() -> Element?

    mutating func read() -> Element?

    @discardableResult
    mutating func skip() -> Bool
}
