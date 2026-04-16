// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct DoubleExtensionsTests {
}

// MARK: -

extension DoubleExtensionsTests {
    @Test
    func test_asFraction() {
        #expect((-1.75).asFraction() == (-7, 4))
        #expect(Double.pi.asFraction() == (355, 113))
        #expect(Double.zero.asFraction() == (0, 1))
        #expect(1.03125.asFraction() == (33, 32))
        #expect((5.0 / 17.0).asFraction() == (5, 17))
    }
}
