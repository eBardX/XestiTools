// © 2018–2026 John Gary Pusey (see LICENSE.md)

private import Foundation

extension String {

    // MARK: Public Instance Properties

    /// This string if it is not empty, `nil` otherwise.
    public var nilIfEmpty: String? {
        isEmpty ? nil : self
    }

    // MARK: Public Instance Methods

    /// Returns a copy of this string with characters escaped as specified.
    ///
    /// If you pass `true` to `unprintableOnly`, the single quote (`'`), double
    /// quote (`"`), and backslash (`\`) characters will _not_ be escaped.
    ///
    /// - Parameter forceASCII:         A Boolean value indicating whether the
    ///                                 escaped string should use ASCII
    ///                                 characters only.
    /// - Parameter unprintableOnly:    A Boolean value indicating whether only
    ///                                 unprintable characters should be
    ///                                 escaped.
    ///
    /// - Returns:  The escaped string.
    public func escaped(asASCII forceASCII: Bool,
                        unprintableOnly: Bool) -> Self {
        func escape(_ chr: Unicode.Scalar) -> Self {
            if unprintableOnly && ["\'", "\"", "\\"].contains(chr) {
                String(chr)
            } else {
                chr.escaped(asASCII: forceASCII)
            }
        }

        return unicodeScalars.map { escape($0) }.joined()
    }

    /// Determines the text location equivalent to the provided index of this
    /// string and returns it.
    ///
    /// - Parameter position:   A valid index of this string.
    ///
    /// - Returns:  The text location, or `nil` if an equivalent text location
    ///             cannot be determined.
    ///
    /// - Precondition: `position` must be a valid index of this string.
    public func location(of position: Self.Index) -> TextLocation? {
        let posRange = NSRange(position..<position,
                               in: self)
        let nsString = self as NSString
        let lineRange = nsString.lineRange(for: posRange)

        var lineNum: UInt = 1

        nsString.enumerateLines { line, stop in
            if nsString.range(of: line,
                              range: lineRange).location == lineRange.location {
                stop.pointee = true
            } else {
                lineNum += 1
            }
        }

        let colNum = UInt(posRange.location - lineRange.location + 1)

        return TextLocation(line: lineNum,
                            column: colNum)
    }

    /// Returns a Boolean value indicating whether the provided glob-like
    /// pattern matches this string.
    ///
    /// The following wildcard characters are recognized in the provided
    /// pattern:
    ///
    /// - `*` — Matches zero or more characters.
    /// - `?` — Matches exactly one character.
    ///
    /// - Parameter pattern:            The glob-like pattern with which to
    ///                                 match.
    /// - Parameter caseInsensitive:    A Boolean value indicating whether the
    ///                                 comparison is case-insensitive. Defaults
    ///                                 to `false`.
    ///
    /// - Returns: `true` if the match succeeds, `false` otherwise.
    public func matches(pattern: Self,
                        caseInsensitive: Bool = false) -> Bool {
        if caseInsensitive {
            _matches(Array(self.lowercased()),
                     Array(pattern.lowercased()))
        } else {
            _matches(Array(self),
                     Array(pattern))
        }
    }
}

// MARK: Private Functions

private func _matches(_ sval: [Character],
                      _ pval: [Character]) -> Bool {
    var tidx = -1
    var midx = 0
    var pidx = 0
    var sidx = 0

    while sidx < sval.count {
        if pidx < pval.count && (pval[pidx] == "?" || sval[sidx] == pval[pidx]) {
            sidx += 1
            pidx += 1
        } else if pidx < pval.count && pval[pidx] == "*" {
            tidx = pidx
            midx = sidx

            pidx += 1
        } else if tidx != -1 {
            pidx = tidx + 1

            midx += 1

            sidx = midx
        } else {
            return false
        }
    }

    while pidx < pval.count && pval[pidx] == "*" {
        pidx += 1
    }

    return pidx == pval.count
}
