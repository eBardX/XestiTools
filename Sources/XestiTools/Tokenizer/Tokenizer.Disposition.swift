// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public enum Disposition {
        case save(Tokenizer.Token.Kind, Tokenizer.Condition?)
        case skip(Tokenizer.Condition?)
    }
}

// MARK: - CustomStringConvertible

extension Tokenizer.Disposition: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .save(kind, condition):
            "save(\(kind), \(condition ?? "nil"))"

        case let .skip(condition):
            "skip(\(condition ?? "nil"))"
        }
    }
}

// MARK: - Sendable

extension Tokenizer.Disposition: Sendable {
}
