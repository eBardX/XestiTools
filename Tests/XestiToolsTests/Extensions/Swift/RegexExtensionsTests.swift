// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
import XestiTools

struct RegexExtensionsTests {
}

// MARK: -

extension RegexExtensionsTests {
    @Test
    func safeLiteralPattern_dynamicRegex() throws {
        let regex = try Regex("abc")

        if let pattern = regex.safeLiteralPattern {
            #expect(pattern == "abc")
        }
    }

    @Test
    func safeLiteralPattern_literalRegex() {
        let regex = /abc/

        if let pattern = regex.safeLiteralPattern {
            #expect(pattern == "abc")
        }
    }
}
