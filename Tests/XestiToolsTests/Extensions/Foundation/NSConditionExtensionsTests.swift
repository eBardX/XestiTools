// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct NSConditionExtensionsTests {
}

// MARK: -

extension NSConditionExtensionsTests {
    @Test
    func test_namedInitializer() {
        let condition = NSCondition(named: "test-condition")

        #expect(condition.name == "test-condition")
    }

    @Test
    func test_namedInitializerWithEmptyName() {
        let condition = NSCondition(named: "")

        #expect(condition.name?.isEmpty == true)
    }
}
