// © 2024–2026 John Gary Pusey (see LICENSE.md)

import Foundation

extension AsyncSequence where Self.Element == UInt8 {
    /// Returns a non-blocking sequence of values decoded from text where each
    /// line is a JSON object. The text is created by decoding the elements of 
    /// `self` as UTF-8.
    ///
    /// - Parameter decoder:    The `JSONDecoder` instance with which to decode
    ///                         each JSON object. Defaults to `JSONDecoder()`.
    ///
    /// - Returns:  A non-blocking sequence of decoded JSON values.
    public func jsonValues<T: Decodable>(decoder: JSONDecoder = JSONDecoder()) -> AsyncJSONValueSequence<Self, T> {
        AsyncJSONValueSequence(base: self,
                               decoder: decoder)
    }
}
