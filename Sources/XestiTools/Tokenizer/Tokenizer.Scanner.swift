// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public struct Scanner {

        // MARK: Public Instance Properties

        public let input: String

        public private(set) var currentCondition: Condition
        public private(set) var currentIndex: String.Index
        public private(set) var userInfo: [UserInfoKey: Any]

        // MARK: Internal Initializers

        internal init(tokenizer: Tokenizer,
                      input: String,
                      userInfo: [UserInfoKey: Any]) {
            self.currentCondition = .initial
            self.currentIndex = input.startIndex
            self.input = input
            self.tokenizer = tokenizer
            self.userInfo = userInfo
        }

        // MARK: Private Instance Properties

        private let tokenizer: Tokenizer
    }
}

// MARK: -

extension Tokenizer.Scanner {

    // MARK: Public Nested Types

    public typealias Error       = Tokenizer.Error
    public typealias Condition   = Tokenizer.Condition
    public typealias Rule        = Tokenizer.Rule
    public typealias Token       = Tokenizer.Token
    public typealias UserInfoKey = Tokenizer.UserInfoKey

    // MARK: Public Instance Subscripts

    public subscript(_ key: UserInfoKey) -> Any? {
        get { userInfo[key] }
        set { userInfo[key] = newValue }
    }

    // MARK: Internal Instance Methods

    internal mutating func scanTokens() throws -> [Token] {
        var tokens: [Token] = []

        if tokenizer.tracing >= .quiet {
            print("----------")
        }

        while currentIndex < input.endIndex {
            let token = try _scanBestToken()

            if tokenizer.tracing >= .verbose {
                print("----------")
            }

            if let token {
                tokens.append(token)
            }
        }

        if tokenizer.tracing >= .quiet {
            print("### Resulting tokens:")

            for token in tokens {
                print("=== \(token.debugDescription)")
            }

            print("----------")
        }

        return tokens
    }

    // MARK: Private Instance Methods

    private mutating func _scanBestToken() throws -> Token? {
        let text = input[currentIndex...]
        let location = text.location

        if tokenizer.tracing >= .verbose {
            print("*** Attempting to match text beginning: \(text.escapedPrefix(location: location)), currentCondition: \(currentCondition)")
        }

        var matchRule: Tokenizer.Rule?
        var matchIndex = currentIndex
        var matchValue: Substring?

        for rule in tokenizer.rules where rule.isActive(for: currentCondition) {
            if tokenizer.tracing >= .veryVerbose {
                print("--- Trying rule \(rule)")
            }

            guard let match = try? rule.regex.prefixMatch(in: text),
                  match.range.lowerBound == currentIndex,
                  match.range.upperBound > matchIndex
            else { continue }

            if tokenizer.tracing >= .veryVerbose {
                print("--- Updating best match")
            }

            matchIndex = match.range.upperBound
            matchRule = rule
            matchValue = match.output
        }

        guard let rule = matchRule,
              let value = matchValue,
              matchIndex > currentIndex
        else { throw Error.unrecognizedToken(text, location) }

        currentIndex = matchIndex

        let outCondition: Condition?
        let token: Token?

        if let disposition = try rule.action(&self,
                                             value,
                                             currentCondition) ?? rule.disposition {
            switch disposition {
            case let .save(kind, cond):
                outCondition = cond ?? currentCondition
                token = Token(kind, value, location)

            case let .skip(cond):
                outCondition = cond ?? currentCondition
                token = nil
            }
        } else {
            outCondition = currentCondition
            token = nil
        }

        if let outCondition,
           currentCondition != outCondition {
            currentCondition = outCondition
        }

        if tokenizer.tracing >= .verbose {
            if let token {
                print("+++ Saving token: \(token.debugDescription)")
            } else {
                let prefix = value.escapedPrefix(maxLength: value.count,
                                                 location: location)

                print("+++ Skipping token: \(prefix)")
            }
        }

        return token
    }
}
