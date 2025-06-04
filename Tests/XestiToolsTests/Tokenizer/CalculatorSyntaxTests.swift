import XCTest
@testable import XestiTools

extension Tokenizer.Token.Kind {
    fileprivate static let float            = Self("float")
    fileprivate static let integer          = Self("integer")
    fileprivate static let leftParenthesis  = Self("leftParenthesis")
    fileprivate static let op               = Self("op")
    fileprivate static let rightParenthesis = Self("rightParenthesis")
}

private let rules: [Tokenizer.Rule] = [.init(/[0-9]+.[0-9]+/, .float),
                                       .init(/[0-9]+/, .integer),
                                       .init(/\(/, .leftParenthesis),
                                       .init(/[\-\*\/\+]/, .op),
                                       .init(/\)/, .rightParenthesis),
                                       .init(regex: /\s+/,
                                             disposition: .skip(nil))]

private let tokenizer = Tokenizer(rules: rules,
                                  tracing: .quiet)

final class CalculatorSyntaxTests: XCTestCase {
    func testIntSum() throws {
        let tokens = try tokenizer.tokenize(input: "1 + 1")

        assertEqualTokens(actual: tokens,
                          expected: [.init(.integer, "1"),
                                     .init(.op, "+"),
                                     .init(.integer, "1")])
    }

    func testFloatSum() throws {
        let tokens = try tokenizer.tokenize(input: "1.2   +      1.004")

        assertEqualTokens(actual: tokens,
                          expected: [.init(.float, "1.2"),
                                     .init(.op, "+"),
                                     .init(.float, "1.004")])
    }

    func testFloatIntSum() throws {
        let tokens = try tokenizer.tokenize(input: "   1332.4322  +       1   ")

        assertEqualTokens(actual: tokens,
                          expected: [.init(.float, "1332.4322"),
                                     .init(.op, "+"),
                                     .init(.integer, "1")])
    }

    func testComplexExpression() throws {
        let tokens = try tokenizer.tokenize(input: "( 1332.4322  +       1   ) *2 / 44.44 + ((2.3- 2) * 4  )   / 0.3       ")

        print(tokens)

        assertEqualTokens(actual: tokens,
                          expected: [.init(.leftParenthesis, "("),
                                     .init(.float, "1332.4322"),
                                     .init(.op, "+"),
                                     .init(.integer, "1"),
                                     .init(.rightParenthesis, ")"),
                                     .init(.op, "*"),
                                     .init(.integer, "2"),
                                     .init(.op, "/"),
                                     .init(.float, "44.44"),
                                     .init(.op, "+"),
                                     .init(.leftParenthesis, "("),
                                     .init(.leftParenthesis, "("),
                                     .init(.float, "2.3"),
                                     .init(.op, "-"),
                                     .init(.integer, "2"),
                                     .init(.rightParenthesis, ")"),
                                     .init(.op, "*"),
                                     .init(.integer, "4"),
                                     .init(.rightParenthesis, ")"),
                                     .init(.op, "/"),
                                     .init(.float, "0.3")])
    }
}
