import XCTest
@testable import XestiTools

func assertEqualTokens(actual: [Tokenizer.Token],
                       expected: [Tokenizer.Token]) {
    XCTAssertEqual(actual.count, expected.count, "Wrong number of tokens")

    for idx in 0..<actual.count {
        XCTAssertEqual(actual[idx].kind, expected[idx].kind, "Wrong token kind at index \(idx)")
        XCTAssertEqual(actual[idx].value, expected[idx].value, "Wrong token value at index \(idx)")
    }
}
