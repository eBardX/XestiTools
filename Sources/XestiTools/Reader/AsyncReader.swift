// © 2025 John Gary Pusey (see LICENSE.md)

public protocol AsyncReader<Element> {
    associatedtype Element

    var hasMore: Bool { get }

    func peek() async throws -> Element?

    mutating func read() async throws -> Element?

    @discardableResult
    mutating func skip() async throws -> Bool
}
