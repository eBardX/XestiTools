// © 2024–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension AsyncJSONValueSequence {

    // MARK: Public Nested Types

    /// An asynchronous iterator that produces the elements of this asynchronous
    /// sequence.
    public struct AsyncIterator: AsyncIteratorProtocol {

        // MARK: Internal Initializers

        internal init(byteSource: Base.AsyncIterator,
                      decoder: JSONDecoder) {
            self.buffer = []
            self.byteSource = byteSource
            self.decoder = decoder
        }

        // MARK: Internal Instance Properties

        @usableFromInline internal let decoder: JSONDecoder

        @usableFromInline internal var buffer: [UInt8]
        @usableFromInline internal var byteSource: Base.AsyncIterator
    }
}

// MARK: -

extension AsyncJSONValueSequence.AsyncIterator {

    // MARK: Public Instance Methods

    /// Asynchronously advances to the next element and returns it, or ends
    /// the sequence if there is no next element.
    ///
    /// - Returns:  The next element from the sequence, if a next element
    ///             exists; otherwise, `nil`.
    @inlinable
    @concurrent
    public mutating func next() async rethrows -> T? {
        func yield() throws -> T? {
            defer { buffer.removeAll(keepingCapacity: true) }

            if buffer.last == 0x0d {
                buffer.removeLast()
            }

            guard !buffer.isEmpty
            else { return nil }

            return try decoder.decode(T.self,
                                      from: Data(buffer))
        }

        while let byte = try await byteSource.next() {
            if byte != 0x0a {
                buffer.append(byte)
            } else if let result = try yield() {
                return result
            }
        }

        return try yield()
    }
}
