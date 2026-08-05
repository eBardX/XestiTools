// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
import XestiTools

struct InterpolatorTests {
}

// MARK: -

extension InterpolatorTests {
    @Test
    func checkedInterpolate_boundaries() {
        let interpolator = LinearInterpolator()

        #expect(interpolator.checkedInterpolate(0) == 0)
        #expect(interpolator.checkedInterpolate(1) == 1)
    }

    @Test
    func checkedInterpolate_passesThroughValidValue() {
        let interpolator = LinearInterpolator()

        #expect(interpolator.checkedInterpolate(0.5) == interpolator.interpolate(0.5))
    }
}
