// © 2025 John Gary Pusey (see LICENSE.md)

extension TokenReader {
    public enum Error {
        case noMoreTokens
        case unexpectedToken(Substring, String.Index)
    }
}

// MARK: - EnhancedError

extension TokenReader.Error: EnhancedError {
    public var message: String {
        switch self {
        case .noMoreTokens:
            "No more tokens"

        case let .unexpectedToken(value, position):
            "Unexpected token: «\(liteEscape(value))», position: ‹\(position)›"
        }
    }
}
