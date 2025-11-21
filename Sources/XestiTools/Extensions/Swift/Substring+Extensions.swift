// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension Substring {

    // MARK: Public Nested Types

    public typealias Location    = String.Location
    public typealias SplitResult = (head: Substring, tail: Substring?)

    // MARK: Public Instance Properties

    public var location: Location {
        base.location(of: startIndex)!  // swiftlint:disable:this force_unwrapping
    }

    // MARK: Public Instance Methods

    public func splitBeforeFirst(_ character: Character) -> SplitResult {
        splitBeforeFirst([character])
    }

    public func splitBeforeFirst(_ characters: Set<Character>) -> SplitResult {
        splitBeforeFirst { characters.contains($0) }
    }

    public func splitBeforeFirst(_ predicate: (Character) throws -> Bool) rethrows -> SplitResult {
        guard let idx = try firstIndex(where: predicate)
        else { return (self, nil) }

        return (self[startIndex..<idx], self[idx..<endIndex])
    }
}
