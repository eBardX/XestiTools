// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct StringRepresentableTests {
}

// MARK: -

extension StringRepresentableTests {
    @Test
    func test_comparable() {
        let cat1 = TestStringType("alpha")
        let cat2 = TestStringType("beta")

        #expect(cat1 < cat2)
        #expect(!(cat2 < cat1))
    }

    @Test
    func test_decodeFromJSON() throws {
        let json = "\"fromJSON\""
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(TestStringType.self,
                                               from: data)

        #expect(decoded.stringValue == "fromJSON")
    }

    @Test
    func test_decodeInvalidValueThrows() throws {
        let json = "\"\""
        let data = Data(json.utf8)

        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(TestStringType.self,
                                     from: data)
        }
    }

    @Test
    func test_description() {
        let category = TestStringType("myCategory")

        #expect(category.description == "myCategory")
    }

    @Test
    func test_encodeDecode() throws {
        let original = TestStringType("codable-test")
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TestStringType.self,
                                               from: data)

        #expect(decoded == original)
    }

    @Test
    func test_equality() {
        let cat1 = TestStringType("abc")
        let cat2 = TestStringType("abc")

        #expect(cat1 == cat2)
    }

    @Test
    func test_hashable() {
        let cat1 = TestStringType("test")
        let cat2 = TestStringType("test")
        let cat3 = TestStringType("other")

        var set = Set<TestStringType>()

        set.insert(cat1)
        set.insert(cat2)
        set.insert(cat3)

        #expect(set.count == 2)
    }

    @Test
    func test_inequality() {
        let cat1 = TestStringType("abc")
        let cat2 = TestStringType("xyz")

        #expect(cat1 != cat2)
    }

    @Test
    func test_init_emptyStringReturnsNil() {
        let category = TestStringType(stringValue: "")

        #expect(category == nil)
    }

    @Test
    func test_init_nonFailable() {
        let category = TestStringType("test")

        #expect(category.stringValue == "test")
    }

    @Test
    func test_init_stringLiteral() {
        let category: TestStringType = "literal"

        #expect(category.stringValue == "literal")
    }

    @Test
    func test_init_validString() {
        let category = TestStringType(stringValue: "test")

        #expect(category != nil)
        #expect(category?.stringValue == "test")
    }

    @Test
    func test_isValid() {
        #expect(TestStringType.isValid("valid"))
        #expect(!TestStringType.isValid(""))
    }
}
