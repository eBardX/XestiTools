// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
 import XestiToolsCore

struct LogisticInterpolatorTests {
}

// MARK: -

extension LogisticInterpolatorTests {
    @Test
    func codable() throws {
        let original = LogisticInterpolator(steepness: 5)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LogisticInterpolator.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func description() {
        #expect(LogisticInterpolator(steepness: 10).description == "‹logistic(steepness: 10.0)›")
        #expect(LogisticInterpolator(steepness: -5).description == "‹logistic(steepness: -5.0)›")
    }

    @Test
    func equatable() {
        let li = LogisticInterpolator(steepness: 10)

        #expect(li == LogisticInterpolator(steepness: 10))
        #expect(li != LogisticInterpolator(steepness: 5))
    }

    @Test
    func hashable() {
        let a = LogisticInterpolator(steepness: 10)
        let b = LogisticInterpolator(steepness: 10)
        let set: Set = [a, b]

        #expect(set.count == 1)
    }

    @Test
    func init_defaultSteepness() {
        #expect(LogisticInterpolator().steepness == 10.0)
    }

    @Test
    func interpolate_boundaries() {
        let interpolator = LogisticInterpolator(steepness: 10)

        #expect(interpolator.interpolate(0) == 0)
        #expect(interpolator.interpolate(1) == 1)
    }

    @Test
    func interpolate_midpoint() {
        let interpolator = LogisticInterpolator(steepness: 10)

        #expect(abs(interpolator.interpolate(0.5) - 0.5) < 1e-10)
    }

    @Test
    func interpolate_negativeSteepness_fastSlowFast() {
        let interpolator = LogisticInterpolator(steepness: -10)

        #expect(interpolator.interpolate(0.25) > 0.25)
        #expect(interpolator.interpolate(0.75) < 0.75)
    }

    @Test
    func interpolate_positiveSteepness_slowFastSlow() {
        let interpolator = LogisticInterpolator(steepness: 10)

        #expect(interpolator.interpolate(0.25) < 0.25)
        #expect(interpolator.interpolate(0.75) > 0.75)
    }

    @Test
    func interpolate_zeroSteepness_linear() {
        let interpolator = LogisticInterpolator(steepness: 0)

        #expect(interpolator.interpolate(0) == 0)
        #expect(interpolator.interpolate(0.25) == 0.25)
        #expect(interpolator.interpolate(0.5) == 0.5)
        #expect(interpolator.interpolate(0.75) == 0.75)
        #expect(interpolator.interpolate(1) == 1)
    }
}
