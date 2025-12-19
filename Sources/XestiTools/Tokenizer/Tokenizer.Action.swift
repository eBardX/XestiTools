// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public typealias Action = @Sendable (_ scanner: inout Scanner,
                                         _ value: Substring,
                                         _ condition: Condition) throws -> Disposition?
}
