// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct ExtendedErrorTests {
}

// MARK: -

extension ExtendedErrorTests {
    @Test
    func test_exitCode_default() {
        let error = MockExtendedError(message: "oops")

        #expect(error.exitCode == .failure)
    }

    @Test
    func test_hints_defaultFromCauses() {
        let inner = MockExtendedError(message: "root cause")
        let outer = MockExtendedError(message: "oops",
                                      cause: inner)

        #expect(outer.hints == ["root cause"])
    }

    @Test
    func test_hints_nestedCauses() {
        let innermost = MockExtendedError(message: "deepest")
        let inner = MockExtendedError(message: "middle",
                                      cause: innermost)
        let outer = MockExtendedError(message: "oops",
                                      cause: inner)

        #expect(outer.hints == ["middle", "deepest"])
    }

    @Test
    func test_hints_noCause() {
        let error = MockExtendedError(message: "oops")

        #expect(error.hints.isEmpty)
    }

    @Test
    func test_hintsPrefix_default() {
        let error = MockExtendedError(message: "oops")

        #expect(error.hintsPrefix == "     - ")
    }

    @Test
    func test_messagePrefix_default() {
        let error = MockExtendedError(message: "oops")

        #expect(error.messagePrefix == "Error: ")
    }
}

// MARK: - MockExtendedError

private struct MockExtendedError: ExtendedError {
    var message: String
    var cause: (any EnhancedError)?
}
