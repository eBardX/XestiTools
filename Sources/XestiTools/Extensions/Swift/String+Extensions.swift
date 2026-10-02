// © 2018–2026 John Gary Pusey (see LICENSE.md)

private import Foundation

extension String {

    // MARK: Public Instance Properties

    /// The value of this string, or `nil` if this string is empty.
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
            if unprintableOnly,
               ["\'", "\"", "\\"].contains(chr) {
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
    /// - Returns:  `true` if the match succeeds, `false` otherwise.
    public func matches(pattern: Self,
                        caseInsensitive: Bool = false) -> Bool {
        if caseInsensitive {
            _matches(Array(lowercased()),
                     Array(pattern.lowercased()))
        } else {
            _matches(Array(self),
                     Array(pattern))
        }
    }

    /// Returns a new string created by normalizing the whitespace in this
    /// string.
    ///
    /// By default, leading and trailing whitespace is removed, and every
    /// internal run of whitespace, including line breaks, is replaced by a
    /// single space:
    ///
    /// ```swift
    /// print("\tHello,   world!\r\n".normalizingWhitespace())
    /// // Prints "Hello, world!"
    /// ```
    ///
    /// If `lineByLine` is `true`, the string is instead normalized one line at
    /// a time. Leading and trailing whitespace is removed from each line, and
    /// internal runs of whitespace within a line are replaced by a single
    /// space. The lines are then rejoined, with these rules:
    ///
    /// - Every line break is written as `"\n"`, whatever its original form
    ///   (`"\r\n"`, `"\r"`, U+2028, and so on).
    /// - A run of blank lines, including lines that held only whitespace, is
    ///   collapsed to a single blank line.
    /// - Leading and trailing blank lines are removed. The result never begins
    ///   or ends with a line break, even if this string ends with one.
    ///
    /// ```swift
    /// print("  Line  1 \r\n\n\n  Line 2\n".normalizingWhitespace(lineByLine: true))
    /// // Prints "Line 1\n\nLine 2"
    /// ```
    ///
    /// Whitespace is as defined by `Character.isWhitespace`, and line breaks by
    /// `Character.isNewline`.
    ///
    /// - Parameter lineByLine:     A Boolean value indicating whether to
    ///                             normalize each line separately and keep the
    ///                             line structure. Defaults to `false`.
    ///
    /// - Returns:  The normalized string.
    public func normalizingWhitespace(lineByLine: Bool = false) -> Self {
        var result = ""
        var lineBreaks = 0
        var inRun = false

        result.reserveCapacity(utf8.count)

        for chr in self {
            if chr.isWhitespace {
                if lineByLine, chr.isNewline {
                    lineBreaks += 1
                }

                inRun = true
            } else {
                //
                // A separator is written only when a run of whitespace ends
                // between two non-whitespace characters, so leading and
                // trailing whitespace is never written:
                //
                if inRun, !result.isEmpty {
                    switch lineBreaks {
                    case 0:
                        result.append(" ")

                    case 1:
                        result.append("\n")

                    default:
                        result.append("\n\n")
                    }
                }

                result.append(chr)

                inRun = false
                lineBreaks = 0
            }
        }

        return result
    }
}

// MARK: - Private Functions

private func _matches(_ sval: [Character],
                      _ pval: [Character]) -> Bool {
    var tidx = -1
    var midx = 0
    var pidx = 0
    var sidx = 0

    while sidx < sval.count {
        if pidx < pval.count,
           pval[pidx] == "?" || sval[sidx] == pval[pidx] {
            sidx += 1
            pidx += 1
        } else if pidx < pval.count,
                  pval[pidx] == "*" {
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

    while pidx < pval.count,
          pval[pidx] == "*" {
        pidx += 1
    }

    return pidx == pval.count
}
