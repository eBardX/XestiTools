// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public struct Token {

        // MARK: Public Instance Properties

        public let kind: Kind
        public let position: String.Index
        public let value: Substring

        // MARK: Internal Initializers

        internal init(_ kind: Kind,
                      _ value: Substring) {
            self.kind = kind
            self.position = value.startIndex
            self.value = value
        }
    }
}

// MARK: - CustomStringConvertible

extension Tokenizer.Token: CustomStringConvertible {
    public var description: String {
        "(‹\(kind)›, «\(liteEscape(value))», ‹\(position)›)"
    }
}
