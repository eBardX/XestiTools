// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct AtomicFlagTests {
}

// MARK: -

extension AtomicFlagTests {
    @Test
    func test_clear_resetsFlag() {
        var flag = AtomicFlag()

        _ = flag.testAndSet()

        flag.clear()

        let result = flag.testAndSet()

        #expect(!result)
    }

    @Test
    func test_clearAndSet_multiple() {
        var flag = AtomicFlag()
        var r1 = flag.testAndSet()

        #expect(!r1)

        r1 = flag.testAndSet()

        #expect(r1)

        flag.clear()

        var r2 = flag.testAndSet()

        #expect(!r2)

        r2 = flag.testAndSet()

        #expect(r2)

        flag.clear()
        flag.clear()

        let r3 = flag.testAndSet()

        #expect(!r3)
    }

    @Test
    func test_testAndSet_initialReturnsFalse() {
        var flag = AtomicFlag()

        let result = flag.testAndSet()

        #expect(!result)
    }

    @Test
    func test_testAndSet_secondReturnsTrue() {
        var flag = AtomicFlag()

        _ = flag.testAndSet()

        let result = flag.testAndSet()

        #expect(result)
    }
}
