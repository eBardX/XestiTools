// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public struct Token {

        // MARK: Public Instance Properties

        public let kind: Kind
        public let location: TextLocation
        public let value: Substring

        // MARK: Internal Initializers

        internal init(_ kind: Kind,
                      _ value: Substring,
                      _ location: TextLocation) {
            self.kind = kind
            self.location = location
            self.value = value
        }
    }
}

// MARK: - CustomDebugStringConvertible

extension Tokenizer.Token: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(kind)(«\(liteEscape(value))»), line: \(location.line), column: \(location.column)"
    }
}

// MARK: - CustomStringConvertible

extension Tokenizer.Token: CustomStringConvertible {
    public var description: String {
        "\(kind)(«\(liteEscape(value))»)"
    }
}
