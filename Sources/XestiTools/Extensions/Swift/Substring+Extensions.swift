// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension Substring {

    // MARK: Public Nested Types

    public typealias SplitResult = (head: Substring, tail: Substring?)

    // MARK: Public Instance Properties

    @inlinable public var location: TextLocation {
        base.location(of: startIndex)!  // swiftlint:disable:this force_unwrapping
    }

    // MARK: Public Instance Methods

    @inlinable
    public func dropPrefix(_ character: Character) -> Substring {
        dropPrefix { character == $0 }
    }

    @inlinable
    public func dropPrefix(_ characters: Set<Character>) -> Substring {
        dropPrefix { characters.contains($0) }
    }

    public func dropPrefix(_ predicate: (Character) throws -> Bool) rethrows -> Substring {
        var idx = startIndex

        while idx < endIndex {
            guard try predicate(self[idx])
            else { break }

            formIndex(after: &idx)
        }

        guard idx < endIndex
        else { return self[endIndex...] }

        return self[idx...]
    }

    @inlinable
    public func dropSuffix(_ character: Character) -> Substring {
        dropSuffix { character == $0 }
    }

    @inlinable
    public func dropSuffix(_ characters: Set<Character>) -> Substring {
        dropSuffix { characters.contains($0) }
    }

    public func dropSuffix(_ predicate: (Character) throws -> Bool) rethrows -> Substring {

        var idx = endIndex

        while idx > startIndex {
            let prvIdx = index(before: idx)

            guard try predicate(self[prvIdx])
            else { break }

            idx = prvIdx
        }

        guard idx > startIndex
        else { return self[..<startIndex] }

        return self[..<idx]
    }

    @inlinable
    public func splitBeforeFirst(_ character: Character) -> SplitResult {
        splitBeforeFirst { character == $0 }
    }

    @inlinable
    public func splitBeforeFirst(_ characters: Set<Character>) -> SplitResult {
        splitBeforeFirst { characters.contains($0) }
    }

    public func splitBeforeFirst(_ predicate: (Character) throws -> Bool) rethrows -> SplitResult {
        guard let idx = try firstIndex(where: predicate)
        else { return (self, nil) }

        return (self[startIndex..<idx], self[idx..<endIndex])
    }

    // MARK: Internal Instance Methods

    internal func escapedPrefix(maxLength: Int = 16,
                                openQuote: String = "«",
                                closeQuote: String = "»",
                                location: TextLocation? = nil) -> String {
        var result = openQuote

        if count > maxLength {
            result += liteEscape(prefix(maxLength)) + "…"
        } else {
            result += liteEscape(self)
        }

        result += closeQuote

        if let location {
            result += ", line: "
            result += location.line.formatted()
            result += ", column: "
            result += location.column.formatted()
        }

        return result
    }
}
