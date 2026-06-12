// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct UIntRepresentableTests {
}

// MARK: -

extension UIntRepresentableTests {
    @Test
    func comparable() {
        let val1 = TestUIntType(1)
        let val2 = TestUIntType(2)

        #expect(val1 < val2)
        #expect(!(val2 < val1))
    }

    @Test
    func decodeFromJSON() throws {
        let json = "99"
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(TestUIntType.self,
                                               from: data)

        #expect(decoded.uintValue == 99)
    }

    @Test
    func decodeInvalidValueThrows() throws {
        let json = "0"
        let data = Data(json.utf8)

        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(TestUIntType.self,
                                     from: data)
        }
    }

    @Test
    func description() {
        let value = TestUIntType(42)

        #expect(value.description == "42")
    }

    @Test
    func encodeDecode() throws {
        let original = TestUIntType(7)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TestUIntType.self,
                                               from: data)

        #expect(decoded == original)
    }

    @Test
    func equality() {
        let val1 = TestUIntType(5)
        let val2 = TestUIntType(5)

        #expect(val1 == val2)
    }

    @Test
    func hashable() {
        let val1 = TestUIntType(1)
        let val2 = TestUIntType(1)
        let val3 = TestUIntType(2)

        var set = Set<TestUIntType>()

        set.insert(val1)
        set.insert(val2)
        set.insert(val3)

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let val1 = TestUIntType(5)
        let val2 = TestUIntType(10)

        #expect(val1 != val2)
    }

    @Test
    func init_integerLiteral() {
        let value: TestUIntType = 10

        #expect(value.uintValue == 10)
    }

    @Test
    func init_invalidValue() {
        let value = TestUIntType(uintValue: 0)

        #expect(value == nil)
    }

    @Test
    func init_nonFailable() {
        let value = TestUIntType(5)

        #expect(value.uintValue == 5)
    }

    @Test
    func init_validValue() {
        let value = TestUIntType(uintValue: 5)

        #expect(value != nil)
        #expect(value?.uintValue == 5)
    }

    @Test
    func isValid() {
        #expect(TestUIntType.isValid(1))
        #expect(TestUIntType.isValid(100))
        #expect(!TestUIntType.isValid(0))
    }
}
