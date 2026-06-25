// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
 import XestiToolsCore

struct NSLockExtensionsTests {
}

// MARK: -

extension NSLockExtensionsTests {
    @Test
    func initNamed() {
        let lock = NSLock(named: "test-lock")

        #expect(lock.name == "test-lock")
    }

    @Test
    func initNamed_emptyName() {
        let lock = NSLock(named: "")

        #expect(lock.name?.isEmpty == true)
    }
}
