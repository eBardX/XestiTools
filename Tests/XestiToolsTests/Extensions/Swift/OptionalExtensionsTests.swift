// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct OptionalExtensionsTests {
}

// MARK: -

extension OptionalExtensionsTests {
    @Test
    func test_nilIfEqual_emptyString() {
        let value: String? = ""

        #expect(value.nilIfEqual(to: "") == nil)

        let result = value.nilIfEqual(to: "x")

        #expect(result?.isEmpty == true)
    }

    @Test
    func test_nilIfEqual_matchingValue() {
        let value: Int? = 5

        #expect(value.nilIfEqual(to: 5) == nil)
    }

    @Test
    func test_nilIfEqual_nilOptional() {
        let value: Int? = nil

        #expect(value.nilIfEqual(to: 5) == nil)
    }

    @Test
    func test_nilIfEqual_nonMatchingValue() {
        let value: Int? = 5

        #expect(value.nilIfEqual(to: 10) == 5)
    }

    @Test
    func test_nilIfEqual_stringValues() {
        let value: String? = "hello"

        #expect(value.nilIfEqual(to: "hello") == nil)
        #expect(value.nilIfEqual(to: "world") == "hello")
    }

    @Test
    func test_require_stringValue() {
        let value: String? = "hello"

        #expect(value.require() == "hello")
    }

    @Test
    func test_require_value() {
        let value: Int? = 42

        #expect(value.require() == 42)
    }
}
