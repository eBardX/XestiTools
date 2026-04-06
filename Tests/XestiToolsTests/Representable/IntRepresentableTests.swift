// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct IntRepresentableTests {
}

// MARK: -

extension IntRepresentableTests {
    @Test
    func test_comparable() {
        let val1 = TestIntType(1)
        let val2 = TestIntType(2)

        #expect(val1 < val2)
        #expect(!(val2 < val1))
    }

    @Test
    func test_decodeFromJSON() throws {
        let json = "99"
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(TestIntType.self,
                                               from: data)

        #expect(decoded.intValue == 99)
    }

    @Test
    func test_decodeInvalidValueThrows() throws {
        let json = "-1"
        let data = Data(json.utf8)

        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(TestIntType.self,
                                     from: data)
        }
    }

    @Test
    func test_description() {
        let value = TestIntType(42)

        #expect(value.description == "42")
    }

    @Test
    func test_encodeDecode() throws {
        let original = TestIntType(7)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TestIntType.self,
                                               from: data)

        #expect(decoded == original)
    }

    @Test
    func test_equality() {
        let val1 = TestIntType(5)
        let val2 = TestIntType(5)

        #expect(val1 == val2)
    }

    @Test
    func test_hashable() {
        let val1 = TestIntType(1)
        let val2 = TestIntType(1)
        let val3 = TestIntType(2)

        var set = Set<TestIntType>()

        set.insert(val1)
        set.insert(val2)
        set.insert(val3)

        #expect(set.count == 2)
    }

    @Test
    func test_inequality() {
        let val1 = TestIntType(5)
        let val2 = TestIntType(10)

        #expect(val1 != val2)
    }

    @Test
    func test_init_integerLiteral() {
        let value: TestIntType = 10

        #expect(value.intValue == 10)
    }

    @Test
    func test_init_invalidValue() {
        let value = TestIntType(intValue: -1)

        #expect(value == nil)
    }

    @Test
    func test_init_nonFailable() {
        let value = TestIntType(5)

        #expect(value.intValue == 5)
    }

    @Test
    func test_init_validValue() {
        let value = TestIntType(intValue: 5)

        #expect(value != nil)
        #expect(value?.intValue == 5)
    }

    @Test
    func test_isValid() {
        #expect(TestIntType.isValid(0))
        #expect(TestIntType.isValid(100))
        #expect(!TestIntType.isValid(-1))
        #expect(!TestIntType.isValid(-100))
    }
}
