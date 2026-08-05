// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
import XestiTools

struct InterpolatableTests {
}

// MARK: -

extension InterpolatableTests {
    @Test
    func fraction_boundaries() {
        #expect(0.0.fraction(from: 0.0, through: 10.0) == 0.0)
        #expect(10.0.fraction(from: 0.0, through: 10.0) == 1.0)
    }

    @Test
    func fraction_midpoint() {
        #expect(5.0.fraction(from: 0.0, through: 10.0) == 0.5)
    }

    @Test
    func value_boundaries() {
        #expect(Double.value(of: 0.0, from: 0.0, through: 10.0) == 0.0)
        #expect(Double.value(of: 1.0, from: 0.0, through: 10.0) == 10.0)
    }

    @Test
    func value_midpoint() {
        #expect(Double.value(of: 0.5, from: 0.0, through: 10.0) == 5.0)
    }
}
