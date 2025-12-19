// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public enum Error {
        case unrecognizedToken(Substring, TextLocation)
    }
}

// MARK: - EnhancedError

extension Tokenizer.Error: EnhancedError {
    public var message: String {
        switch self {
        case let .unrecognizedToken(value, location):
            "Unrecognized token beginning: \(value.escapedPrefix(location: location))"
        }
    }
}

// MARK: - Sendable

extension Tokenizer.Error: Sendable {
}
