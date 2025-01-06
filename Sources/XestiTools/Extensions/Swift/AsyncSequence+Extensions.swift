// © 2024 John Gary Pusey (see LICENSE.md)

import Foundation

extension AsyncSequence where Self.Element == UInt8 {
    public func jsonValues<T: Decodable>(decoder: JSONDecoder = .init()) -> AsyncJSONValueSequence<Self, T> {
        .init(base: self,
              decoder: decoder)
    }
}
