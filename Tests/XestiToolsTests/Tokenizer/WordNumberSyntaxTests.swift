import XCTest
@testable import XestiTools

extension Tokenizer.Token.Kind {
    fileprivate static let number = Self("number")
    fileprivate static let text   = Self("text")
}

private let rules: [Tokenizer.Rule] = [.init(/[0-9]+/, .number),
                                       .init(/[A-Za-z]+/, .text),
                                       .init(regex: /\s+/,
                                             disposition: .skip(nil))]

private let tokenizer = Tokenizer(rules: rules,
                                  tracing: .quiet)

final class WordNumberSyntaxTests: XCTestCase {
    func testWords() throws {
        let tokens = try tokenizer.tokenize(input: "  HELLO  h i abc  ABC   Hi   hello         boy        XD")

        assertEqualTokens(actual: tokens,
                          expected: [.init(.text, "HELLO"),
                                     .init(.text, "h"),
                                     .init(.text, "i"),
                                     .init(.text, "abc"),
                                     .init(.text, "ABC"),
                                     .init(.text, "Hi"),
                                     .init(.text, "hello"),
                                     .init(.text, "boy"),
                                     .init(.text, "XD")])
    }

    func testNumbers() throws {
        let tokens = try tokenizer.tokenize(input: "  233 2    1  23123    3333333     324    33    2")

        assertEqualTokens(actual: tokens,
                          expected: [.init(.number, "233"),
                                     .init(.number, "2"),
                                     .init(.number, "1"),
                                     .init(.number, "23123"),
                                     .init(.number, "3333333"),
                                     .init(.number, "324"),
                                     .init(.number, "33"),
                                     .init(.number, "2")])
    }

    func testWordsAndNumbers() throws {
        let tokens = try tokenizer.tokenize(input: "  233 2    1  23123abc  ABC   Hi3333333     324    33    2")

        assertEqualTokens(actual: tokens,
                          expected: [.init(.number, "233"),
                                     .init(.number, "2"),
                                     .init(.number, "1"),
                                     .init(.number, "23123"),
                                     .init(.text, "abc"),
                                     .init(.text, "ABC"),
                                     .init(.text, "Hi"),
                                     .init(.number, "3333333"),
                                     .init(.number, "324"),
                                     .init(.number, "33"),
                                     .init(.number, "2")])
    }
}
