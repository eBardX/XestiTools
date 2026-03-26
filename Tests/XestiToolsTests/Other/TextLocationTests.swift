// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct TextLocationTests {
}

// MARK: -

extension TextLocationTests {
    @Test
    func test_codable() throws {
        let original = TextLocation(5, 10)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TextLocation.self,
                                               from: data)

        #expect(decoded == original)
    }

    @Test
    func test_equality() {
        let loc1 = TextLocation(1, 2)
        let loc2 = TextLocation(1, 2)

        #expect(loc1 == loc2)
    }

    @Test
    func test_failableInitWithBothZero() {
        let location = TextLocation(line: 0, column: 0)

        #expect(location == nil)
    }

    @Test
    func test_failableInitWithValidValues() {
        let location = TextLocation(line: 3, column: 5)

        #expect(location != nil)
        #expect(location?.line == 3)
        #expect(location?.column == 5)
    }

    @Test
    func test_failableInitWithZeroColumn() {
        let location = TextLocation(line: 5, column: 0)

        #expect(location == nil)
    }

    @Test
    func test_failableInitWithZeroLine() {
        let location = TextLocation(line: 0, column: 5)

        #expect(location == nil)
    }

    @Test
    func test_hashable() {
        let loc1 = TextLocation(1, 2)
        let loc2 = TextLocation(1, 2)

        var set = Set<TextLocation>()

        set.insert(loc1)
        set.insert(loc2)

        #expect(set.count == 1)
    }

    @Test
    func test_inequality() {
        let loc1 = TextLocation(1, 2)
        let loc2 = TextLocation(1, 3)
        let loc3 = TextLocation(2, 2)

        #expect(loc1 != loc2)
        #expect(loc1 != loc3)
    }

    @Test
    func test_initWithLargeValues() {
        let location = TextLocation(1_000, 500)

        #expect(location.line == 1_000)
        #expect(location.column == 500)
    }

    @Test
    func test_initWithValidValues() {
        let location = TextLocation(1, 1)

        #expect(location.line == 1)
        #expect(location.column == 1)
    }
}
