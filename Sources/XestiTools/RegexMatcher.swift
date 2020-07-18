// © 2018–2020 J. G. Pusey (see LICENSE.md)

import Foundation

public final class RegexMatcher {

    // MARK: Public Initializers

    public init(pattern: String) {
        do {
            self.regex = try NSRegularExpression(pattern: pattern)
        } catch {
            fatalError("Bad regex pattern, error: \(error)")
        }
    }

    // MARK: Public Instance Methods

    public func firstMatch(in string: String) -> [String]? {
        let searchString = string as NSString
        let searchRange = NSRange(location: 0,
                                  length: searchString.length)

        guard
            let result = regex.firstMatch(in: string,
                                          range: searchRange),
            result.range == searchRange,
            result.resultType == .regularExpression
            else { return nil }

        var ranges: [NSRange] = []

        for idx in 0..<result.numberOfRanges {
            ranges.append(result.range(at: idx))
        }

        return ranges.map { range in
            guard
                range.location != NSNotFound,
                range.length > 0
                else { return "" }

            return searchString.substring(with: range)
        }
    }

    // MARK: Private Instance Properties

    private let regex: NSRegularExpression
}

// MARK: - ExpressibleByStringLiteral

extension RegexMatcher: ExpressibleByStringLiteral {
    public convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(pattern: value)
    }

    public convenience init(stringLiteral value: String) {
        self.init(pattern: value)
    }

    public convenience init(unicodeScalarLiteral value: String) {
        self.init(pattern: value)
    }
}
