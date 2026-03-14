// © 2024–2026 John Gary Pusey (see LICENSE.md)

import Foundation

extension AsyncSequence where Self.Element == UInt8 {
    public func jsonValues<T: Decodable>(decoder: JSONDecoder = JSONDecoder()) -> AsyncJSONValueSequence<Self, T> {
        AsyncJSONValueSequence(base: self,
                               decoder: decoder)
    }
}
