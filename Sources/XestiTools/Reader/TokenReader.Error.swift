// © 2025 John Gary Pusey (see LICENSE.md)

extension TokenReader {
    public enum Error {
        case noMoreTokens
        case unexpectedToken(Token)
    }
}

// MARK: - EnhancedError

extension TokenReader.Error: EnhancedError {
    public var message: String {
        switch self {
        case .noMoreTokens:
            "No more tokens"

        case let .unexpectedToken(token):
            "Unexpected token: \(token)"
        }
    }
}

// MARK: - Sendable

extension TokenReader.Error: Sendable {
}
