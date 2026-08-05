// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct LookupTableTests {
}

// MARK: -

extension LookupTableTests {
    @Test
    func codable() throws {
        var original = LookupTable<Double, Double, LinearInterpolator>(defaultValue: -1.0,
                                                                       interpolator: LinearInterpolator())

        original.insert(key: 0.0, value: 0.0)
        original.insert(key: 1.0, value: 10.0)

        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LookupTable<Double, Double, LinearInterpolator>.self,
                                               from: data)

        #expect(decoded.defaultValue == original.defaultValue)
        #expect(decoded.interpolator == original.interpolator)
        #expect(decoded[0.5] == original[0.5])
    }

    @Test
    func init_empty() {
        let table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 42.0,
                                                                    interpolator: LinearInterpolator())

        #expect(table.isEmpty)
        #expect(table.defaultValue == 42.0)
        #expect(!table.hasExtras)
    }
}
