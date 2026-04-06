// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct NSLockExtensionsTests {
}

// MARK: -

extension NSLockExtensionsTests {
    @Test
    func test_initNamed() {
        let lock = NSLock(named: "test-lock")

        #expect(lock.name == "test-lock")
    }

    @Test
    func test_initNamed_emptyName() {
        let lock = NSLock(named: "")

        #expect(lock.name?.isEmpty == true)
    }
}
