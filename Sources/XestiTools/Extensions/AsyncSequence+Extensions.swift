// © 2024 John Gary Pusey (see LICENSE.md)

extension AsyncSequence where Self.Element == UInt8 {
    public func jsonValues<T: Decodable>() -> AsyncJSONValueSequence<Self, T> {
        .init(base: self)
    }
}
