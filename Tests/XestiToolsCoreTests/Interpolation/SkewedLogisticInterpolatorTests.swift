// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
 import XestiToolsCore

struct SkewedLogisticInterpolatorTests {
}

// MARK: -

extension SkewedLogisticInterpolatorTests {
    @Test
    func codable() throws {
        let original = SkewedLogisticInterpolator(leadingSteepness: 8,
                                                  trailingSteepness: 12,
                                                  center: 0.3)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(SkewedLogisticInterpolator.self,
                                               from: data)

        #expect(decoded == original)
    }

    @Test
    func description() {
        let interp = SkewedLogisticInterpolator(leadingSteepness: 10,
                                                trailingSteepness: 10,
                                                center: 0.5)

        #expect(interp.description == "‹skewedLogistic(leadingSteepness: 10.0, trailingSteepness: 10.0, center: 0.5)›")
    }

    @Test
    func equatable() {
        let a = SkewedLogisticInterpolator(leadingSteepness: 10,
                                           trailingSteepness: 10,
                                           center: 0.5)
        let b = SkewedLogisticInterpolator(leadingSteepness: 10,
                                           trailingSteepness: 10,
                                           center: 0.5)
        let c = SkewedLogisticInterpolator(leadingSteepness: 5,
                                           trailingSteepness: 10,
                                           center: 0.5)

        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func hashable() {
        let a = SkewedLogisticInterpolator(leadingSteepness: 10,
                                           trailingSteepness: 10,
                                           center: 0.5)
        let b = SkewedLogisticInterpolator(leadingSteepness: 10,
                                           trailingSteepness: 10,
                                           center: 0.5)
        let set: Set = [a, b]

        #expect(set.count == 1)
    }

    @Test
    func init_defaultParameters() {
        let interp = SkewedLogisticInterpolator()

        #expect(interp.leadingSteepness == 10.0)
        #expect(interp.trailingSteepness == 10.0)
        #expect(interp.center == 0.5)
    }

    @Test
    func interpolate_atCenter() {
        let interp = SkewedLogisticInterpolator(leadingSteepness: 10,
                                                trailingSteepness: 10,
                                                center: 0.3)

        #expect(interp.interpolate(0.3) == 0.5)
    }

    @Test
    func interpolate_boundaries() {
        let interp = SkewedLogisticInterpolator(leadingSteepness: 10,
                                                trailingSteepness: 10,
                                                center: 0.4)

        #expect(interp.interpolate(0) == 0)
        #expect(interp.interpolate(1) == 1)
    }

    @Test
    func interpolate_equalSteepness_matchesLogistic() {
        let skewed = SkewedLogisticInterpolator(leadingSteepness: 10,
                                                trailingSteepness: 10,
                                                center: 0.5)
        let logistic = LogisticInterpolator(steepness: 10)

        for t in [0.0, 0.1, 0.25, 0.5, 0.75, 0.9, 1.0] {
            let diff = abs(skewed.interpolate(t) - logistic.interpolate(t))

            #expect(diff < 1e-10)
        }
    }

    @Test
    func interpolate_skewedCenter_linear() {
        let interp = SkewedLogisticInterpolator(leadingSteepness: 0,
                                                trailingSteepness: 0,
                                                center: 0.25)

        #expect(interp.interpolate(0) == 0)
        #expect(interp.interpolate(0.125) == 0.25)
        #expect(interp.interpolate(0.25) == 0.5)
        #expect(interp.interpolate(0.625) == 0.75)
        #expect(interp.interpolate(1) == 1)
    }

    @Test
    func interpolate_zeroSteepness_linear() {
        let interp = SkewedLogisticInterpolator(leadingSteepness: 0,
                                                trailingSteepness: 0,
                                                center: 0.5)

        #expect(interp.interpolate(0) == 0)
        #expect(interp.interpolate(0.25) == 0.25)
        #expect(interp.interpolate(0.5) == 0.5)
        #expect(interp.interpolate(0.75) == 0.75)
        #expect(interp.interpolate(1) == 1)
    }
}
