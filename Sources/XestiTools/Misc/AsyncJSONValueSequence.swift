// © 2024 John Gary Pusey (see LICENSE.md)

import Foundation

public struct AsyncJSONValueSequence<Base: AsyncSequence,
                                     T: Decodable>: AsyncSequence where Base.Element == UInt8 {

    // MARK: Public Nested Types

    public typealias Element = T

    public struct AsyncIterator: AsyncIteratorProtocol {

        // MARK: Public Instance Methods

        @inlinable
        public mutating func next() async rethrows -> T? {
            func _yield() throws -> T? {
                defer { buffer.removeAll(keepingCapacity: true) }

                guard !buffer.isEmpty
                else { return nil }

                return try decoder.decode(T.self,
                                          from: Data(buffer))
            }

            while let byte = try await byteSource.next() {
                if byte != 0x0A {
                    buffer.append(byte)
                } else if let result = try _yield() {
                    return result
                }
            }

            return try _yield()
        }

        // MARK: Internal Initializers

        internal init(byteSource: Base.AsyncIterator) {
            self.buffer = []
            self.byteSource = byteSource
            self.decoder = .init()
        }

        // MARK: Internal Instance Properties

        @usableFromInline internal let decoder: JSONDecoder

        @usableFromInline internal var buffer: [UInt8]
        @usableFromInline internal var byteSource: Base.AsyncIterator
    }

    // MARK: Public Instance Methods

    public func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator(byteSource: base.makeAsyncIterator())
    }

    // MARK: Internal Initializers

    internal init(base: Base) {
        self.base = base
    }

    // MARK: Private Instance Properties

    private var base: Base
}
