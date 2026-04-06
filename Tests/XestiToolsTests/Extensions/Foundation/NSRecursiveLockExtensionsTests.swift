// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct NSRecursiveLockExtensionsTests {
}

// MARK: -

extension NSRecursiveLockExtensionsTests {
    @Test
    func test_initNamed() {
        let lock = NSRecursiveLock(named: "test-recursive-lock")

        #expect(lock.name == "test-recursive-lock")
    }

    @Test
    func test_initNamed_emptyName() {
        let lock = NSRecursiveLock(named: "")

        #expect(lock.name?.isEmpty == true)
    }
}
