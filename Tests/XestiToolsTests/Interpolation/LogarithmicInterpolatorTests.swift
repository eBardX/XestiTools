// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct LogarithmicInterpolatorTests {
}

// MARK: -

extension LogarithmicInterpolatorTests {
    @Test
    func codable() throws {
        let original = LogarithmicInterpolator(base: 2)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LogarithmicInterpolator.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func description() {
        #expect(LogarithmicInterpolator(base: 2).description == "‹logarithmic(base: 2.0)›")
    }

    @Test
    func equatable() {
        let li = LogarithmicInterpolator(base: 2)

        #expect(li == LogarithmicInterpolator(base: 2))
        #expect(LogarithmicInterpolator(base: 2) != LogarithmicInterpolator(base: 10))
    }

    @Test
    func hashable() {
        let a = LogarithmicInterpolator(base: 2)
        let b = LogarithmicInterpolator(base: 2)
        let set: Set = [a, b]

        #expect(set.count == 1)
    }

    @Test
    func interpolate_alwaysDecelerates() {
        let interpolator = LogarithmicInterpolator(base: 2)

        #expect(interpolator.interpolate(0) == 0)
        #expect(interpolator.interpolate(1) == 1)
        #expect(interpolator.interpolate(0.25) > 0.25)
        #expect(interpolator.interpolate(0.5) > 0.5)
        #expect(interpolator.interpolate(0.75) > 0.75)
    }

    @Test
    func interpolate_largerBase_morePronounced() {
        let low = LogarithmicInterpolator(base: 2)
        let high = LogarithmicInterpolator(base: 10)

        #expect(high.interpolate(0.5) > low.interpolate(0.5))
    }
}
