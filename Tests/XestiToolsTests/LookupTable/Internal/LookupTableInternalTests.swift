// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct LookupTableInternalTests {
}

// MARK: -

extension LookupTableInternalTests {
    @Test
    func determineHasExtras_empty() {
        #expect(!TestLookupTable.determineHasExtras([]))
    }

    @Test
    func determineHasExtras_noExtras() {
        let entries: [TestLookupTable.Entry] = [.simple(0.0, 0.0),
                                                .simple(1.0, 1.0)]

        #expect(!TestLookupTable.determineHasExtras(entries))
    }

    @Test
    func determineHasExtras_withExtras() {
        let entries: [TestLookupTable.Entry] = [.simple(0.0, 0.0),
                                                .custom(1.0, 1.0, Extras(elements: [.marker]))]

        #expect(TestLookupTable.determineHasExtras(entries))
    }

    @Test
    func indexForInserting_afterLast() {
        var table = TestLookupTable(defaultValue: 0.0,
                                    interpolator: LinearInterpolator())

        table.insert(key: 1.0, value: 10.0)
        table.insert(key: 2.0, value: 20.0)

        #expect(table.indexForInserting(key: 3.0, value: 30.0, extras: nil) == 2)
    }

    @Test
    func indexForInserting_beforeFirst() {
        var table = TestLookupTable(defaultValue: 0.0,
                                    interpolator: LinearInterpolator())

        table.insert(key: 1.0, value: 10.0)
        table.insert(key: 2.0, value: 20.0)

        #expect(table.indexForInserting(key: 0.0, value: 0.0, extras: nil) == 0)
    }

    @Test
    func indexForInserting_between() {
        var table = TestLookupTable(defaultValue: 0.0,
                                    interpolator: LinearInterpolator())

        table.insert(key: 1.0, value: 10.0)
        table.insert(key: 3.0, value: 30.0)

        #expect(table.indexForInserting(key: 2.0, value: 20.0, extras: nil) == 1)
    }

    @Test
    func indexForInserting_duplicateKey() {
        var table = TestLookupTable(defaultValue: 0.0,
                                    interpolator: LinearInterpolator())

        table.insert(key: 1.0, value: 10.0)
        table.insert(key: 1.0, value: 11.0)
        table.insert(key: 2.0, value: 20.0)

        #expect(table.indexForInserting(key: 1.0, value: 12.0, extras: nil) == 2)
    }

    @Test
    func indexForInserting_empty() {
        let table = TestLookupTable(defaultValue: 0.0,
                                    interpolator: LinearInterpolator())

        #expect(table.indexForInserting(key: 1.0, value: 10.0, extras: nil) == 0)
    }

    @Test
    func indexMatching_extrasMismatch() {
        var table = TestLookupTable(defaultValue: 0.0,
                                    interpolator: LinearInterpolator())

        table.insert(key: 1.0, value: 10.0, extras: Extras(elements: [.marker]))

        #expect(table.indexMatching(key: 1.0, value: 10.0, extras: nil) == nil)
    }

    @Test
    func indexMatching_found() {
        var table = TestLookupTable(defaultValue: 0.0,
                                    interpolator: LinearInterpolator())

        table.insert(key: 1.0, value: 10.0)
        table.insert(key: 2.0, value: 20.0, extras: Extras(elements: [.marker]))

        #expect(table.indexMatching(key: 2.0, value: 20.0, extras: Extras(elements: [.marker])) == 1)
    }

    @Test
    func indexMatching_keyMismatch() {
        var table = TestLookupTable(defaultValue: 0.0,
                                    interpolator: LinearInterpolator())

        table.insert(key: 1.0, value: 10.0)

        #expect(table.indexMatching(key: 2.0, value: 10.0, extras: nil) == nil)
    }

    @Test
    func indexMatching_valueMismatch() {
        var table = TestLookupTable(defaultValue: 0.0,
                                    interpolator: LinearInterpolator())

        table.insert(key: 1.0, value: 10.0)

        #expect(table.indexMatching(key: 1.0, value: 11.0, extras: nil) == nil)
    }
}
