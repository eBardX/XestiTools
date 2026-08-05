// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct FloatRepresentableTests {
}

// MARK: -

extension FloatRepresentableTests {
    @Test
    func comparable() {
        let val1 = TestFloatType(1.0)
        let val2 = TestFloatType(2.0)

        #expect(val1 < val2)
        #expect(!(val2 < val1))
    }

    @Test
    func decodeFromJSON() throws {
        let json = "9.5"
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(TestFloatType.self,
                                               from: data)

        #expect(decoded.doubleValue == 9.5)
    }

    @Test
    func decodeInvalidValueThrows() throws {
        let json = "-1.0"
        let data = Data(json.utf8)

        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(TestFloatType.self,
                                     from: data)
        }
    }

    @Test
    func description() {
        let value = TestFloatType(4.25)

        #expect(value.description == "4.25")
    }

    @Test
    func encodeDecode() throws {
        let original = TestFloatType(7.5)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TestFloatType.self,
                                               from: data)

        #expect(decoded == original)
    }

    @Test
    func equality() {
        let val1 = TestFloatType(5.0)
        let val2 = TestFloatType(5.0)

        #expect(val1 == val2)
    }

    @Test
    func hashable() {
        let val1 = TestFloatType(1.0)
        let val2 = TestFloatType(1.0)
        let val3 = TestFloatType(2.0)

        var set = Set<TestFloatType>()

        set.insert(val1)
        set.insert(val2)
        set.insert(val3)

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let val1 = TestFloatType(5.0)
        let val2 = TestFloatType(10.0)

        #expect(val1 != val2)
    }

    @Test
    func init_floatLiteral() {
        let value: TestFloatType = 2.5

        #expect(value.doubleValue == 2.5)
    }

    @Test
    func init_integerLiteral() {
        let value: TestFloatType = 10

        #expect(value.doubleValue == 10.0)
    }

    @Test
    func init_invalidValue() {
        let value = TestFloatType(doubleValue: -1.0)

        #expect(value == nil)
    }

    @Test
    func init_nonFailable() {
        let value = TestFloatType(5.5)

        #expect(value.doubleValue == 5.5)
    }

    @Test
    func init_validValue() {
        let value = TestFloatType(doubleValue: 5.5)

        #expect(value != nil)
        #expect(value?.doubleValue == 5.5)
    }

    @Test
    func isValid() {
        #expect(TestFloatType.isValid(0.0))
        #expect(TestFloatType.isValid(100.0))
        #expect(!TestFloatType.isValid(-1.0))
        #expect(!TestFloatType.isValid(-100.0))
    }
}
