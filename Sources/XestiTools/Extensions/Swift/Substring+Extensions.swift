// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Substring {

    // MARK: Public Nested Types

    /// The result of a split operation.
    ///
    /// This is a tuple containing two named values:
    ///
    /// - Term head:    The slice of the substring containing the characters
    ///                 _before_ the split character. If the split character is
    ///                 not found, the head slice spans the entire substring.
    /// - Term tail:    The slice of the substring containing the characters
    ///                 from the split character to the end. If the split
    ///                 character is not found, the tail slice is `nil`.
    public typealias SplitResult = (head: Substring, tail: Substring?)

    // MARK: Public Instance Properties

    /// The text location of this substring relative to its base string.
    @inlinable public var location: TextLocation {
        base.location(of: startIndex)!  // swiftlint:disable:this force_unwrapping
    }

    // MARK: Public Instance Methods

    /// Drops any initial characters in this substring that match the given
    /// character and returns the remaining characters in a new substring.
    ///
    /// - Parameter character:  The character that should be dropped.
    ///
    /// - Returns:  The resulting substring.
    @inlinable
    public func dropPrefix(_ character: Character) -> Substring {
        dropPrefix { character == $0 }
    }

    /// Drops any initial characters in this substring that are contained in the
    /// given set of characters and returns the remaining characters in a new
    /// substring.
    ///
    /// - Parameter characters: The set of characters that should be dropped.
    ///
    /// - Returns:  The resulting substring.
    @inlinable
    public func dropPrefix(_ characters: Set<Character>) -> Substring {
        dropPrefix { characters.contains($0) }
    }

    /// Drops any initial characters in this substring that satisfy the given
    /// predicate and returns the remaining characters in a new substring.
    ///
    /// - Parameter predicate:  A closure that accepts a character as its
    ///                         argument and returns a Boolean value indicating
    ///                         whether that character should be dropped.
    ///
    /// - Returns:  The resulting substring.
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

    /// Drops any final characters in this substring that match the given
    /// character and returns the remaining characters in a new substring.
    ///
    /// - Parameter character:  The character that should be dropped.
    ///
    /// - Returns:  The resulting substring.
    @inlinable
    public func dropSuffix(_ character: Character) -> Substring {
        dropSuffix { character == $0 }
    }

    /// Drops any final characters in this substring that are contained in the
    /// given set of characters and returns the remaining characters in a new
    /// substring.
    ///
    /// - Parameter characters: The set of characters that should be dropped.
    ///
    /// - Returns:  The resulting substring.
    @inlinable
    public func dropSuffix(_ characters: Set<Character>) -> Substring {
        dropSuffix { characters.contains($0) }
    }

    /// Drops any final characters in this substring that satisfy the given
    /// predicate and returns the remaining characters in a new substring.
    ///
    /// - Parameter predicate:  A closure that accepts a character as its
    ///                         argument and returns a Boolean value indicating
    ///                         whether that character should be dropped.
    ///
    /// - Returns:  The resulting substring.
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

    /// Splits this substring before the first occurrence of the given
    /// character.
    ///
    /// - Parameter character:  The character on which to split.
    ///
    /// - Returns:  The result of the split. See ``SplitResult``.
    @inlinable
    public func splitBeforeFirst(_ character: Character) -> SplitResult {
        splitBeforeFirst { character == $0 }
    }

    /// Splits this substring before the first occurrence of a character
    /// contained in the given set of characters.
    ///
    /// - Parameter characters: The set of characters on which to split.
    ///
    /// - Returns:  The result of the split. See ``SplitResult``.
    @inlinable
    public func splitBeforeFirst(_ characters: Set<Character>) -> SplitResult {
        splitBeforeFirst { characters.contains($0) }
    }

    /// Splits this substring before the first occurrence of a character
    /// satisfying the given predicate.
    ///
    /// - Parameter predicate:  A closure that accepts a character as its
    ///                         argument and returns a Boolean value indicating
    ///                         whether the substring should be split at that
    ///                         character.
    ///
    /// - Returns:  The result of the split. See ``SplitResult``.
    public func splitBeforeFirst(_ predicate: (Character) throws -> Bool) rethrows -> SplitResult {
        guard let idx = try firstIndex(where: predicate)
        else { return (self, nil) }

        return (self[startIndex..<idx], self[idx..<endIndex])
    }
}
