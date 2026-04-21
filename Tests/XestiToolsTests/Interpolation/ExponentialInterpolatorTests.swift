// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct ExponentialInterpolatorTests {
}

// MARK: -

extension ExponentialInterpolatorTests {
    @Test
    func codable() throws {
        let original = ExponentialInterpolator(base: 2, power: 1)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(ExponentialInterpolator.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func description() {
        #expect(ExponentialInterpolator(base: 2, power: 1).description == "‹exponential(base: 2.0, power: 1.0)›")
    }

    @Test
    func equatable() {
        let ei = ExponentialInterpolator(base: 2, power: 1)

        #expect(ei == ExponentialInterpolator(base: 2, power: 1))
        #expect(ExponentialInterpolator(base: 2, power: 1) != ExponentialInterpolator(base: 3, power: 1))
    }

    @Test
    func hashable() {
        let a = ExponentialInterpolator(base: 2, power: 1)
        let b = ExponentialInterpolator(base: 2, power: 1)
        let set: Set = [a, b]

        #expect(set.count == 1)
    }

    @Test
    func interpolate_baseGreaterThan1_accelerates() {
        let interpolator = ExponentialInterpolator(base: 2, power: 1)

        #expect(interpolator.interpolate(0) == 0)
        #expect(interpolator.interpolate(1) == 1)
        #expect(interpolator.interpolate(0.5) < 0.5)
    }

    @Test
    func interpolate_baseLessThan1_decelerates() {
        let interpolator = ExponentialInterpolator(base: 0.5, power: 1)

        #expect(interpolator.interpolate(0) == 0)
        #expect(interpolator.interpolate(1) == 1)
        #expect(interpolator.interpolate(0.5) > 0.5)
    }
}
