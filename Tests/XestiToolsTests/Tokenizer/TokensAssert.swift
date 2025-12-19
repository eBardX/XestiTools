// © 2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

func assertEqualTokens(actual: [Tokenizer.Token],
                       expected: [Tokenizer.Token]) {
    #expect(actual.count == expected.count, "Wrong number of tokens")

    for idx in 0..<actual.count {
        #expect(actual[idx].kind == expected[idx].kind, "Wrong token kind at index \(idx)")
        #expect(actual[idx].value == expected[idx].value, "Wrong token value at index \(idx)")
    }
}
