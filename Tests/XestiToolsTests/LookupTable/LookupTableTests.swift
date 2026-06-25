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
    func forEach() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                    interpolator: LinearInterpolator())

        table.insert(key: 0.0, value: 10.0)
        table.insert(key: 1.0, value: 20.0)

        var keys: [Double] = []
        var values: [Double] = []

        table.forEach { key, value, _ in
            keys.append(key)
            values.append(value)
        }

        #expect(keys == [0.0, 1.0])
        #expect(values == [10.0, 20.0])
    }

    @Test
    func hasExtras_false() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                    interpolator: LinearInterpolator())

        table.insert(key: 0.0, value: 0.0)

        #expect(!table.hasExtras)
    }

    @Test
    func init_empty() {
        let table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 42.0,
                                                                    interpolator: LinearInterpolator())

        #expect(table.isEmpty)
        #expect(table.defaultValue == 42.0)
        #expect(!table.hasExtras)
    }

    @Test
    func insert_mutating() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                    interpolator: LinearInterpolator())

        #expect(table.isEmpty)

        table.insert(key: 1.0, value: 5.0)

        #expect(!table.isEmpty)
    }

    @Test
    func inserting_nonMutating() {
        let original = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                       interpolator: LinearInterpolator())
        let updated = original.inserting(key: 0.5, value: 3.0)

        #expect(original.isEmpty)
        #expect(!updated.isEmpty)
    }

    @Test
    func isEmpty() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                    interpolator: LinearInterpolator())

        #expect(table.isEmpty)

        table.insert(key: 0.0, value: 0.0)

        #expect(!table.isEmpty)
    }

    @Test
    func merge_mutating() {
        var tableA = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                     interpolator: LinearInterpolator())
        var tableB = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                     interpolator: LinearInterpolator())

        tableA.insert(key: 0.0, value: 0.0)
        tableB.insert(key: 1.0, value: 1.0)

        tableA.merge(with: tableB)

        #expect(tableA[0.5] == 0.5)
    }

    @Test
    func merging_nonMutating() {
        var tableA = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                     interpolator: LinearInterpolator())
        var tableB = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                     interpolator: LinearInterpolator())

        tableA.insert(key: 0.0, value: 0.0)
        tableB.insert(key: 1.0, value: 1.0)

        let merged = tableA.merging(with: tableB)

        #expect(!tableA.isEmpty)
        #expect(tableA[0.5] != 0.5)
        #expect(merged[0.5] == 0.5)
    }

    @Test
    func remove_mutating() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                    interpolator: LinearInterpolator())

        table.insert(key: 0.5, value: 7.0)
        table.remove(key: 0.5, value: 7.0)

        #expect(table.isEmpty)
    }

    @Test
    func removing_nonMutating() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 0.0,
                                                                    interpolator: LinearInterpolator())

        table.insert(key: 0.5, value: 7.0)

        let trimmed = table.removing(key: 0.5, value: 7.0)

        #expect(!table.isEmpty)
        #expect(trimmed.isEmpty)
    }

    @Test
    func subscript_beforeFirst() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: -1.0,
                                                                    interpolator: LinearInterpolator())

        table.insert(key: 0.0, value: 10.0)
        table.insert(key: 1.0, value: 20.0)

        #expect(table[-0.5] == 10.0)
    }

    @Test
    func subscript_beyondLast() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: -1.0,
                                                                    interpolator: LinearInterpolator())

        table.insert(key: 0.0, value: 10.0)
        table.insert(key: 1.0, value: 20.0)

        #expect(table[2.0] == 20.0)
    }

    @Test
    func subscript_empty() {
        let table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: 99.0,
                                                                    interpolator: LinearInterpolator())

        #expect(table[0.5] == 99.0)
    }

    @Test
    func subscript_exactKey() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: -1.0,
                                                                    interpolator: LinearInterpolator())

        table.insert(key: 0.0, value: 10.0)
        table.insert(key: 1.0, value: 20.0)

        #expect(table[0.0] == 10.0)
        #expect(table[1.0] == 20.0)
    }

    @Test
    func subscript_interpolated() {
        var table = LookupTable<Double, Double, LinearInterpolator>(defaultValue: -1.0,
                                                                    interpolator: LinearInterpolator())

        table.insert(key: 0.0, value: 0.0)
        table.insert(key: 1.0, value: 100.0)

        #expect(table[0.5] == 50.0)
        #expect(table[0.25] == 25.0)
        #expect(table[0.75] == 75.0)
    }
}
