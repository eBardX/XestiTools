// © 2025 John Gary Pusey (see LICENSE.md)

public struct Tokenizer {

    // MARK: Public Initializers

    public init(rules: [Rule],
                userInfo: [UserInfoKey: any Sendable] = [:],
                tracing: Verbosity = .silent) {
        self.rules = rules
        self.tracing = tracing
        self.userInfo = userInfo
    }

    // MARK: Public Instance Properties

    public let rules: [Rule]
    public let tracing: Verbosity
    public let userInfo: [UserInfoKey: any Sendable]

    // MARK: Public Instance Methods

    public func tokenize(input: String) throws -> [Token] {
        var scanner = Scanner(tokenizer: self,
                              input: input,
                              userInfo: userInfo)

        return try scanner.scanTokens()
    }
}
