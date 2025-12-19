// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension Tokenizer {

    // MARK: Public Nested Types

    public struct RuleID: StringRepresentable {

        // MARK: Public Type Properties

        public static let invalidMessage = "rule ID must be valid"

        // MARK: Public Type Methods

        public static func isValid(_ stringValue: String) -> Bool {
            stringValue.wholeMatch(of: validPattern) != nil
        }

        // MARK: Public Initializers

        public init(_ stringValue: String) {
            self.stringValue = Self.requireValid(stringValue)
        }

        // MARK: Public Instance Properties

        public let stringValue: String

        // MARK: Private Type Properties

        nonisolated(unsafe) private static let validPattern = /R\$[0-9A-Za-z]{22}/

        private static let validPrefix = "R$"
    }
}

// MARK: - (convenience)

extension Tokenizer.RuleID {

    // MARK: Public Initializers

    public init() {
        self.init(Self.validPrefix + UUID().base62String)
    }
}
