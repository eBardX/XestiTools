// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct LookupTableEntryTests {
}

// MARK: -

extension LookupTableEntryTests {
    @Test
    func codable_custom() throws {
        let original = TestLookupTable.Entry(key: 1.0,
                                             value: 2.0,
                                             extras: Extras(elements: [.marker]))
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TestLookupTable.Entry.self,
                                               from: data)

        #expect(decoded == original)
    }

    @Test
    func codable_simple() throws {
        let original = TestLookupTable.Entry(key: 1.0,
                                             value: 2.0,
                                             extras: nil)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TestLookupTable.Entry.self,
                                               from: data)

        #expect(decoded == original)
    }

    @Test
    func comparable() {
        let lower = TestLookupTable.Entry(key: 1.0,
                                          value: 9.0,
                                          extras: nil)
        let higher = TestLookupTable.Entry(key: 2.0,
                                           value: 0.0,
                                           extras: nil)
        let same = lower

        #expect(lower < higher)
        #expect(!(higher < lower))
        #expect(!(lower < same))
    }

    @Test
    func decode_simpleFromRawJSON() throws {
        let data = Data("[1.5, 3]".utf8)
        let entry = try JSONDecoder().decode(TestLookupTable.Entry.self,
                                             from: data)

        #expect(entry.key == 1.5)
        #expect(entry.value == 3.0)
        #expect(entry.extras == nil)
    }

    @Test
    func encode_simpleOmitsExtras() throws {
        let entry = TestLookupTable.Entry(key: 1.0,
                                          value: 2.0,
                                          extras: nil)
        let data = try JSONEncoder().encode(entry)
        let json = try #require(String(data: data,
                                       encoding: .utf8))

        #expect(json == "[1,2]")
    }

    @Test
    func init_emptyExtras() {
        let entry = TestLookupTable.Entry(key: 1.0,
                                          value: 2.0,
                                          extras: Extras())

        #expect(entry == .simple(1.0, 2.0))
        #expect(entry.extras == nil)
    }

    @Test
    func init_nilExtras() {
        let entry = TestLookupTable.Entry(key: 1.0,
                                          value: 2.0,
                                          extras: nil)

        #expect(entry == .simple(1.0, 2.0))
        #expect(entry.extras == nil)
    }

    @Test
    func init_nonEmptyExtras() {
        let extras = Extras(elements: [.marker])
        let entry = TestLookupTable.Entry(key: 1.0,
                                          value: 2.0,
                                          extras: extras)

        #expect(entry == .custom(1.0, 2.0, extras))
        #expect(entry.extras == extras)
    }

    @Test
    func key_custom() {
        let entry = TestLookupTable.Entry.custom(3.0, 4.0, Extras(elements: [.marker]))

        #expect(entry.key == 3.0)
    }

    @Test
    func key_simple() {
        let entry = TestLookupTable.Entry.simple(3.0, 4.0)

        #expect(entry.key == 3.0)
    }

    @Test
    func value_custom() {
        let entry = TestLookupTable.Entry.custom(3.0, 4.0, Extras(elements: [.marker]))

        #expect(entry.value == 4.0)
    }

    @Test
    func value_simple() {
        let entry = TestLookupTable.Entry.simple(3.0, 4.0)

        #expect(entry.value == 4.0)
    }
}
