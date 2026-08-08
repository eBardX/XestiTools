// © 2024–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation

/// An asynchronous sequence of values decoded from text where each line is a
/// JSON object.
public struct AsyncJSONValueSequence<Base: AsyncSequence,
                                     T: Decodable>: AsyncSequence where Base.Element == UInt8 {

    // MARK: Public Type Aliases

    /// The type of element produced by this asynchronous sequence.
    ///
    /// This is the type into which the underlying decoder will decode each JSON
    /// object.
    public typealias Element = T

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

// MARK: -

extension AsyncJSONValueSequence {

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
}
