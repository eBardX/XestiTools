// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public typealias Action = (_ scanner: Scanner,
                               _ value: Substring,
                               _ condition: Condition) throws -> Disposition?
}
