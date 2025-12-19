// © 2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

private typealias Kind  = Token.Kind
private typealias Rule  = Tokenizer.Rule
private typealias Token = Tokenizer.Token

extension Kind {
    fileprivate static let number = Self("number")
    fileprivate static let text   = Self("text")
}

private let rules: [Rule] = [Rule(/[0-9]+/, .number),
                             Rule(/[A-Za-z]+/, .text),
                             Rule(regex: /\s+/,
                                  disposition: .skip(nil))]

private let tokenizer = Tokenizer(rules: rules,
                                  tracing: .silent)

struct WordNumberSyntaxTests {
}

// MARK: -

extension WordNumberSyntaxTests {
    @Test
    func numbers() throws {
        let tokens = try tokenizer.tokenize(input: "  233 2    1  23123    3333333     324    33    2")

        assertEqualTokens(actual: tokens,
                          expected: [makeToken(.number, "233"),
                                     makeToken(.number, "2"),
                                     makeToken(.number, "1"),
                                     makeToken(.number, "23123"),
                                     makeToken(.number, "3333333"),
                                     makeToken(.number, "324"),
                                     makeToken(.number, "33"),
                                     makeToken(.number, "2")])
    }

    @Test
    func words() throws {
        let tokens = try tokenizer.tokenize(input: "  HELLO  h i abc  ABC   Hi   hello         boy        XD")

        assertEqualTokens(actual: tokens,
                          expected: [makeToken(.text, "HELLO"),
                                     makeToken(.text, "h"),
                                     makeToken(.text, "i"),
                                     makeToken(.text, "abc"),
                                     makeToken(.text, "ABC"),
                                     makeToken(.text, "Hi"),
                                     makeToken(.text, "hello"),
                                     makeToken(.text, "boy"),
                                     makeToken(.text, "XD")])
    }

    @Test
    func wordsAndNumbers() throws {
        let tokens = try tokenizer.tokenize(input: "  233 2    1  23123abc  ABC   Hi3333333     324    33    2")

        assertEqualTokens(actual: tokens,
                          expected: [makeToken(.number, "233"),
                                     makeToken(.number, "2"),
                                     makeToken(.number, "1"),
                                     makeToken(.number, "23123"),
                                     makeToken(.text, "abc"),
                                     makeToken(.text, "ABC"),
                                     makeToken(.text, "Hi"),
                                     makeToken(.number, "3333333"),
                                     makeToken(.number, "324"),
                                     makeToken(.number, "33"),
                                     makeToken(.number, "2")])
    }
}

// MARK: - Private Functions

private func makeToken(_ kind: Kind,
                       _ value: String) -> Token {
    Token(kind, Substring(value), TextLocation(1, 1))
}
