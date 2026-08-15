// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
import XestiTools

struct InterpolatableKeyTests {
}

// MARK: -

extension InterpolatableKeyTests {
    @Test
    func fraction_boundaries() {
        #expect(0.0.fraction(from: 0.0, through: 10.0) == 0.0)
        #expect(10.0.fraction(from: 0.0, through: 10.0) == 1.0)
    }

    @Test
    func fraction_midpoint() {
        #expect(5.0.fraction(from: 0.0, through: 10.0) == 0.5)
    }
}
