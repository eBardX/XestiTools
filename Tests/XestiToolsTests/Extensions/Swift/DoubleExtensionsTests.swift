// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct DoubleExtensionsTests {
}

// MARK: -

extension DoubleExtensionsTests {
    @Test
    func test_rationalized() {
        #expect((-1.75).rationalized() == (-7, 4))
        #expect(Double.pi.rationalized() == (355, 113))
        #expect(Double.zero.rationalized() == (0, 1))
        #expect(1.03125.rationalized() == (33, 32))
        #expect((5.0 / 17.0).rationalized() == (5, 17))
    }
}
