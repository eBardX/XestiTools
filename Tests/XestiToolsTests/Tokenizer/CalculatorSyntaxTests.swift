// © 2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

private typealias Kind  = Token.Kind
private typealias Rule  = Tokenizer.Rule
private typealias Token = Tokenizer.Token

extension Kind {
    fileprivate static let float            = Self("float")
    fileprivate static let integer          = Self("integer")
    fileprivate static let leftParenthesis  = Self("leftParenthesis")
    fileprivate static let op               = Self("op")
    fileprivate static let rightParenthesis = Self("rightParenthesis")
}

nonisolated(unsafe) private let rules: [Rule] = [Rule(/[0-9]+.[0-9]+/, .float),
                                                 Rule(/[0-9]+/, .integer),
                                                 Rule(/\(/, .leftParenthesis),
                                                 Rule(/[\-\*\/\+]/, .op),
                                                 Rule(/\)/, .rightParenthesis),
                                                 Rule(regex: /\s+/,
                                                      disposition: .skip(nil))]

nonisolated(unsafe) private let tokenizer = Tokenizer(rules: rules,
                                                      tracing: .silent)

struct CalculatorSyntaxTests {
}

// MARK: -

extension CalculatorSyntaxTests {
    @Test
    func complexExpression() throws {
        let tokens = try tokenizer.tokenize(input: "( 1332.4322  +       1   ) *2 / 44.44 + ((2.3- 2) * 4  )   / 0.3       ")

        assertEqualTokens(actual: tokens,
                          expected: [makeToken(.leftParenthesis, "("),
                                     makeToken(.float, "1332.4322"),
                                     makeToken(.op, "+"),
                                     makeToken(.integer, "1"),
                                     makeToken(.rightParenthesis, ")"),
                                     makeToken(.op, "*"),
                                     makeToken(.integer, "2"),
                                     makeToken(.op, "/"),
                                     makeToken(.float, "44.44"),
                                     makeToken(.op, "+"),
                                     makeToken(.leftParenthesis, "("),
                                     makeToken(.leftParenthesis, "("),
                                     makeToken(.float, "2.3"),
                                     makeToken(.op, "-"),
                                     makeToken(.integer, "2"),
                                     makeToken(.rightParenthesis, ")"),
                                     makeToken(.op, "*"),
                                     makeToken(.integer, "4"),
                                     makeToken(.rightParenthesis, ")"),
                                     makeToken(.op, "/"),
                                     makeToken(.float, "0.3")])
    }

    @Test
    func floatIntSum() throws {
        let tokens = try tokenizer.tokenize(input: "   1332.4322  +       1   ")

        assertEqualTokens(actual: tokens,
                          expected: [makeToken(.float, "1332.4322"),
                                     makeToken(.op, "+"),
                                     makeToken(.integer, "1")])
    }

    @Test
    func floatSum() throws {
        let tokens = try tokenizer.tokenize(input: "1.2   +      1.004")

        assertEqualTokens(actual: tokens,
                          expected: [makeToken(.float, "1.2"),
                                     makeToken(.op, "+"),
                                     makeToken(.float, "1.004")])
    }

    @Test
    func intSum() throws {
        let tokens = try tokenizer.tokenize(input: "1 + 1")

        assertEqualTokens(actual: tokens,
                          expected: [makeToken(.integer, "1"),
                                     makeToken(.op, "+"),
                                     makeToken(.integer, "1")])
    }
}

// MARK: - Private Functions

private func makeToken(_ kind: Kind,
                       _ value: String) -> Token {
    Token(kind, Substring(value), TextLocation(1, 1))
}
