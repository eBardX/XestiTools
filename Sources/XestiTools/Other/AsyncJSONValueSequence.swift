// © 2024–2026 John Gary Pusey (see LICENSE.md)

import Foundation

/// An asynchronous sequence of values decoded from text where each line is a
/// JSON object.
public struct AsyncJSONValueSequence<Base: AsyncSequence,
                                     T: Decodable>: AsyncSequence where Base.Element == UInt8 {

    // MARK: Public Nested Types

    /// The type of element produced by this asynchronous sequence.
    ///
    /// This is the type into which the underlying decoder will decode each JSON
    /// object.
    public typealias Element = T

    /// An asynchronous iterator that produces the elements of this asynchronous
    /// sequence.
    public struct AsyncIterator: AsyncIteratorProtocol {

        // MARK: Public Instance Methods

        /// Asynchronously advances to the next element and returns it, or ends
        /// the sequence if there is no next element.
        ///
        /// - Returns:  The next element from the sequence, if a next element
        ///             exists; otherwise, `nil`.
        @inlinable
        public mutating func next() async rethrows -> T? {
            func yield() throws -> T? {
                defer { buffer.removeAll(keepingCapacity: true) }

                guard !buffer.isEmpty
                else { return nil }

                return try decoder.decode(T.self,
                                          from: Data(buffer))
            }

            while let byte = try await byteSource.next() {
                if byte != 0x0A {
                    buffer.append(byte)
                } else if let result = try yield() {
                    return result
                }
            }

            return try yield()
        }

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

    // MARK: Public Instance Methods

    /// Creates a new, _single-use_ asynchronous iterator that produces the
    /// elements of this asynchronous sequence.
    ///
    /// - Returns:  An asynchronous iterator instance that produces the elements
    ///             of this asynchronous sequence.
    public func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator(byteSource: base.makeAsyncIterator(),
                      decoder: decoder)
    }

    // MARK: Internal Initializers

    internal init(base: Base,
                  decoder: JSONDecoder = JSONDecoder()) {
        self.base = base
        self.decoder = decoder
    }

    // MARK: Private Instance Properties

    private let decoder: JSONDecoder

    private var base: Base
}
