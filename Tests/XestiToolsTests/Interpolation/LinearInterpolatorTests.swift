// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct LinearInterpolatorTests {
}

// MARK: -

extension LinearInterpolatorTests {
    @Test
    func codable() throws {
        let original = LinearInterpolator()
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LinearInterpolator.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func description() {
        #expect(LinearInterpolator().description == "‹linear›")
    }

    @Test
    func equatable() {
        let li = LinearInterpolator()

        #expect(li == LinearInterpolator())
    }

    @Test
    func hashable() {
        let set: Set = [LinearInterpolator(), LinearInterpolator()]

        #expect(set.count == 1)
    }

    @Test
    func interpolate_boundaries() {
        let interpolator = LinearInterpolator()

        #expect(interpolator.interpolate(0) == 0)
        #expect(interpolator.interpolate(1) == 1)
    }

    @Test
    func interpolate_uniformRate() {
        let interpolator = LinearInterpolator()

        #expect(interpolator.interpolate(0.25) == 0.25)
        #expect(interpolator.interpolate(0.5) == 0.5)
        #expect(interpolator.interpolate(0.75) == 0.75)
    }
}
