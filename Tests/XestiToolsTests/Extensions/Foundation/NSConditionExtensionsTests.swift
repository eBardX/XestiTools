// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
 import XestiTools

struct NSConditionExtensionsTests {
}

// MARK: -

extension NSConditionExtensionsTests {
    @Test
    func initNamed() {
        let condition = NSCondition(named: "test-condition")

        #expect(condition.name == "test-condition")
    }

    @Test
    func initNamed_emptyName() {
        let condition = NSCondition(named: "")

        #expect(condition.name?.isEmpty == true)
    }
}
