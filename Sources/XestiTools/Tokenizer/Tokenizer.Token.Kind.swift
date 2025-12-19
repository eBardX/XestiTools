// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer.Token {

    // MARK: Public Nested Types

    public struct Kind: StringRepresentable {

        // MARK: Public Initializers

        public init(_ stringValue: String) {
            self.stringValue = Self.requireValid(stringValue)
        }

        // MARK: Public Instance Properties

        public let stringValue: String
    }
}

// MARK: - CustomStringConvertible

extension Tokenizer.Token.Kind: CustomStringConvertible {
    public var description: String {
        "‹" + stringValue + "›"
    }
}
