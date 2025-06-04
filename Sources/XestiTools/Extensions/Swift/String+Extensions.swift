// © 2018–2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension String {

    // MARK: Public Instance Properties

    public var localized: String {
        NSLocalizedString(self, comment: "")    // swiftlint:disable:this nslocalizedstring_key
    }

    public var nilIfEmpty: String? {
        isEmpty ? nil : self
    }

    // MARK: Public Instance Methods

    public func escaped(asASCII forceASCII: Bool,
                        unprintableOnly: Bool) -> String {
        func escape(_ chr: Unicode.Scalar) -> String {
            if unprintableOnly && ["\'", "\"", "\\"].contains(chr) {
                String(chr)
            } else {
                chr.escaped(asASCII: forceASCII)
            }
        }

        var result = ""

        for chr in unicodeScalars {
            result.append(escape(chr))
        }

        return result
    }

    public func matches(pattern: String,
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
