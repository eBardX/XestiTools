// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct UIntRepresentableTests {
}

// MARK: -

extension UIntRepresentableTests {

    @Test
    func test_comparable() {
        let val1 = TestUIntType(1)
        let val2 = TestUIntType(2)

        #expect(val1 < val2)
        #expect(!(val2 < val1))
    }

    @Test
    func test_decodeFromJSON() throws {
        let json = "99"
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(TestUIntType.self,
                                               from: data)

        #expect(decoded.uintValue == 99)
    }

    @Test
    func test_decodeInvalidValueThrows() throws {
        let json = "0"
        let data = Data(json.utf8)

        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(TestUIntType.self,
                                     from: data)
        }
    }

    @Test
    func test_description() {
        let value = TestUIntType(42)

        #expect(value.description == "42")
    }

    @Test
    func test_encodeDecode() throws {
        let original = TestUIntType(7)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TestUIntType.self,
                                               from: data)

        #expect(decoded == original)
    }

    @Test
    func test_equality() {
        let val1 = TestUIntType(5)
        let val2 = TestUIntType(5)

        #expect(val1 == val2)
    }

    @Test
    func test_hashable() {
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
    func test_inequality() {
        let val1 = TestUIntType(5)
        let val2 = TestUIntType(10)

        #expect(val1 != val2)
    }

    @Test
    func test_initWithInvalidValue() {
        let value = TestUIntType(uintValue: 0)

        #expect(value == nil)
    }

    @Test
    func test_initWithValidValue() {
        let value = TestUIntType(uintValue: 5)

        #expect(value != nil)
        #expect(value?.uintValue == 5)
    }

    @Test
    func test_integerLiteralInit() {
        let value: TestUIntType = 10

        #expect(value.uintValue == 10)
    }

    @Test
    func test_isValid() {
        #expect(TestUIntType.isValid(1))
        #expect(TestUIntType.isValid(100))
        #expect(!TestUIntType.isValid(0))
    }

    @Test
    func test_nonFailableInit() {
        let value = TestUIntType(5)

        #expect(value.uintValue == 5)
    }
}

// MARK: - Test Helpers

private struct TestUIntType: UIntRepresentable {
    static func isValid(_ uintValue: UInt) -> Bool {
        uintValue > 0
    }

    init?(uintValue: UInt) {
        guard Self.isValid(uintValue)
        else { return nil }

        self.uintValue = uintValue
    }

    let uintValue: UInt
}
