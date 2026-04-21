// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct PolynomialInterpolatorTests {
}

// MARK: -

extension PolynomialInterpolatorTests {
    @Test
    func codable() throws {
        let original = PolynomialInterpolator(power: 2)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(PolynomialInterpolator.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func description() {
        #expect(PolynomialInterpolator(power: 2).description == "‹polynomial(power: 2.0)›")
    }

    @Test
    func equatable() {
        let pi = PolynomialInterpolator(power: 2)

        #expect(pi == PolynomialInterpolator(power: 2))
        #expect(PolynomialInterpolator(power: 2) != PolynomialInterpolator(power: 3))
    }

    @Test
    func hashable() {
        let a = PolynomialInterpolator(power: 2)
        let b = PolynomialInterpolator(power: 2)
        let set: Set = [a, b]

        #expect(set.count == 1)
    }

    @Test
    func interpolate_boundaries() {
        let interpolator = PolynomialInterpolator(power: 2)

        #expect(interpolator.interpolate(0) == 0)
        #expect(interpolator.interpolate(1) == 1)
    }

    @Test
    func interpolate_power1_isLinear() {
        let interpolator = PolynomialInterpolator(power: 1)

        #expect(interpolator.interpolate(0.25) == 0.25)
        #expect(interpolator.interpolate(0.5) == 0.5)
        #expect(interpolator.interpolate(0.75) == 0.75)
    }

    @Test
    func interpolate_powerGreaterThan1_accelerates() {
        // power == 2: output is t², which lags input in (0, 1)
        let interpolator = PolynomialInterpolator(power: 2)

        #expect(interpolator.interpolate(0.5) == 0.25)
        #expect(interpolator.interpolate(0.75) < 0.75)
    }

    @Test
    func interpolate_powerLessThan1_decelerates() {
        // power == 0.5: output is √t, which leads input in (0, 1)
        let interpolator = PolynomialInterpolator(power: 0.5)

        #expect(interpolator.interpolate(0.25) == 0.5)
        #expect(interpolator.interpolate(0.75) > 0.75)
    }
}
