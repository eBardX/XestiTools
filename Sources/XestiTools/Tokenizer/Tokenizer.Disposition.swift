// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public enum Disposition: Sendable {
        case save(Tokenizer.Token.Kind, Tokenizer.Condition?)
        case skip(Tokenizer.Condition?)
    }
}
