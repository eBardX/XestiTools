// © 2025 John Gary Pusey (see LICENSE.md)

public struct TokenReader {

    // MARK: Public Nested Types

    public typealias Kind  = Tokenizer.Token.Kind
    public typealias Token = Tokenizer.Token

    // MARK: Public Initializers

    public init(_ tokens: [Token]) {
        self.baseReader = .init(tokens)
    }

    // MARK: Private Instance Properties

    private var baseReader: SequenceReader<[Token]>
}

// MARK: -

extension TokenReader {

    // MARK: Public Instance Properties

    public var hasMore: Bool {
        baseReader.hasMore
    }

    // MARK: Public Instance Methods

    public mutating func failOnNext() throws {
        guard let token = baseReader.read()
        else { throw Error.noMoreTokens }

        throw Error.unexpectedToken(token)
    }

    public func nextMatches(_ kind: Kind) -> Bool {
        nextMatches([kind])
    }

    public func nextMatches(_ kinds: [Kind]) -> Bool {
        guard let token = baseReader.peek(),
              kinds.contains(token.kind)
        else { return false }

        return true
    }

    @discardableResult
    public mutating func readIfMatches(_ kind: Kind) -> Token? {
        readIfMatches([kind])
    }

    @discardableResult
    public mutating func readIfMatches(_ kinds: [Kind]) -> Token? {
        guard let token = baseReader.peek(),
              kinds.contains(token.kind)
        else { return nil }

        baseReader.skip()

        return token
    }

    @discardableResult
    public mutating func readMustMatch(_ kind: Kind) throws -> Token {
        try readMustMatch([kind])
    }

    @discardableResult
    public mutating func readMustMatch(_ kinds: [Kind]) throws -> Token {
        guard let token = baseReader.read()
        else { throw Error.noMoreTokens }

        guard kinds.contains(token.kind)
        else { throw Error.unexpectedToken(token) }

        return token
    }
}
