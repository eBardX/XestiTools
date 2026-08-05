// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
import XestiTools

struct EnhancedErrorTests {
}

// MARK: -

extension EnhancedErrorTests {
    @Test
    func category_default() {
        let error = TestEnhancedError(message: "oops")

        #expect(error.category == nil)
    }

    @Test
    func category_explicit() {
        let error = TestEnhancedError(message: "oops",
                                      category: Category("network"))

        #expect(error.category?.stringValue == "network")
    }

    @Test
    func cause_default() {
        let error = TestEnhancedError(message: "oops")

        #expect(error.cause == nil)
    }

    @Test
    func cause_present() {
        let inner = TestEnhancedError(message: "inner")
        let outer = TestEnhancedError(message: "outer",
                                      cause: inner)

        #expect(outer.cause?.message == "inner")
    }

    @Test
    func dictionaryRepresentation_messageAlwaysPresent() {
        let error = TestEnhancedError(message: "oops")

        #expect(error.dictionaryRepresentation["message"] as? String == "oops")
    }

    @Test
    func dictionaryRepresentation_withCategoryOmitsNSErrorBridging() {
        let error = TestEnhancedError(message: "oops",
                                      category: Category("network"))
        let dict = error.dictionaryRepresentation

        #expect(dict["category"] as? String == "network")
        #expect(dict["domain"] == nil)
        #expect(dict["code"] == nil)
    }

    @Test
    func dictionaryRepresentation_withCause() {
        let inner = TestEnhancedError(message: "inner")
        let outer = TestEnhancedError(message: "outer",
                                      cause: inner)
        let dict = outer.dictionaryRepresentation
        let causeDict = dict["cause"] as? [String: Any]

        #expect(causeDict?["message"] as? String == "inner")
    }

    @Test
    func dictionaryRepresentation_withoutCategoryBridgesToNSError() {
        let error = TestEnhancedError(message: "oops")
        let dict = error.dictionaryRepresentation

        #expect(dict["category"] == nil)
        #expect(dict["domain"] != nil)
        #expect(dict["code"] != nil)
    }
}
