// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct ConstantInterpolatorTests {
}

// MARK: -

extension ConstantInterpolatorTests {
    @Test
    func codable() throws {
        let original = ConstantInterpolator()
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(ConstantInterpolator.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func description() {
        #expect(ConstantInterpolator().description == "‹constant›")
    }

    @Test
    func equatable() {
        let ci = ConstantInterpolator()

        #expect(ci == ConstantInterpolator())
    }

    @Test
    func hashable() {
        let set: Set = [ConstantInterpolator(), ConstantInterpolator()]

        #expect(set.count == 1)
    }

    @Test
    func interpolate_alwaysReturnsZero() {
        let interpolator = ConstantInterpolator()

        #expect(interpolator.interpolate(0) == 0)
        #expect(interpolator.interpolate(0.25) == 0)
        #expect(interpolator.interpolate(0.5) == 0)
        #expect(interpolator.interpolate(0.75) == 0)
        #expect(interpolator.interpolate(1) == 0)
    }
}
