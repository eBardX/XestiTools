// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public enum Error {
        case unrecognizedToken(Substring, String.Index)
    }
}

// MARK: - EnhancedError

extension Tokenizer.Error: EnhancedError {
    public var message: String {
        switch self {
        case let .unrecognizedToken(value, position):
            "Unrecognized token: «\(liteEscape(value))», position: ‹\(position)›"
        }
    }
}
