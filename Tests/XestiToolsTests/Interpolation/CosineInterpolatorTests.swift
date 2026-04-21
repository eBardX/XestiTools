// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct CosineInterpolatorTests {
}

// MARK: -

extension CosineInterpolatorTests {
    @Test
    func codable() throws {
        let original = CosineInterpolator()
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(CosineInterpolator.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func description() {
        #expect(CosineInterpolator().description == "‹cosine›")
    }

    @Test
    func equatable() {
        let ci = CosineInterpolator()

        #expect(ci == CosineInterpolator())
    }

    @Test
    func hashable() {
        let set: Set = [CosineInterpolator(), CosineInterpolator()]

        #expect(set.count == 1)
    }

    @Test
    func interpolate_boundaries() {
        let interpolator = CosineInterpolator()

        #expect(interpolator.interpolate(0) == 0)
        #expect(interpolator.interpolate(1) == 1)
    }

    @Test
    func interpolate_midpoint() {
        // cos(π/2) is not exactly 0 in floating point, so use a tolerance
        #expect(abs(CosineInterpolator().interpolate(0.5) - 0.5) < 1e-10)
    }

    @Test
    func interpolate_sCurveShape() {
        let interpolator = CosineInterpolator()

        // First quarter: slow start — output lags input
        #expect(interpolator.interpolate(0.25) < 0.25)
        // Last quarter: slow finish — output leads input
        #expect(interpolator.interpolate(0.75) > 0.75)
    }
}
