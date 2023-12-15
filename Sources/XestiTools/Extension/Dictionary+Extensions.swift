// © 2023 J. G. Pusey (see LICENSE.md)

extension Dictionary {
    
    // MARK: Public Instance Methods
    
    public func compactMapKeys<T>(_ transform: (Key) throws -> T?) rethrows -> [T: Value] {
        try reduce(into: [T: Value]()) { result, element in
            if let key = try transform(element.key) {
                result[key] = element.value
            }
        }
    }
    
    public func mapKeys<T>(_ transform: (Key) throws -> T) rethrows -> [T: Value] {
        try reduce(into: [T: Value]()) { result, element in
            result[try transform(element.key)] = element.value
        }
    }
}
