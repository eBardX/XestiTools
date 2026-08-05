// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
import XestiTools

struct CategoryTests {
}

// MARK: -

extension CategoryTests {
    @Test
    func init_emptyStringReturnsNil() {
        let category = Category(stringValue: "")

        #expect(category == nil)
    }

    @Test
    func init_validString() {
        let category = Category(stringValue: "network")

        #expect(category?.stringValue == "network")
    }
}
