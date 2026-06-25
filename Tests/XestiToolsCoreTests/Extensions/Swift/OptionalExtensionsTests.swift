// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
 import XestiToolsCore

struct OptionalExtensionsTests {
}

// MARK: -

extension OptionalExtensionsTests {
    @Test
    func nilIfEqual_emptyString() {
        let value: String? = ""

        #expect(value.nilIfEqual(to: "") == nil)

        let result = value.nilIfEqual(to: "x")

        #expect(result?.isEmpty == true)
    }

    @Test
    func nilIfEqual_matchingValue() {
        let value: Int? = 5

        #expect(value.nilIfEqual(to: 5) == nil)
    }

    @Test
    func nilIfEqual_nilOptional() {
        let value: Int? = nil

        #expect(value.nilIfEqual(to: 5) == nil)
    }

    @Test
    func nilIfEqual_nonMatchingValue() {
        let value: Int? = 5

        #expect(value.nilIfEqual(to: 10) == 5)
    }

    @Test
    func nilIfEqual_stringValues() {
        let value: String? = "hello"

        #expect(value.nilIfEqual(to: "hello") == nil)
        #expect(value.nilIfEqual(to: "world") == "hello")
    }

    @Test
    func require_stringValue() {
        let value: String? = "hello"

        #expect(value.require() == "hello")
    }

    @Test
    func require_value() {
        let value: Int? = 42

        #expect(value.require() == 42)
    }
}
