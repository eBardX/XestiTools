// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct NSErrorExtensionsTests {
}

// MARK: -

extension NSErrorExtensionsTests {
    @Test
    func test_cause_absent() {
        let error = NSError(domain: "TestDomain",
                            code: 1)

        #expect(error.cause == nil)
    }

    @Test
    func test_cause_nonEnhancedUnderlying() {
        let underlying = NSError(domain: "PlainDomain",
                                 code: 99,
                                 userInfo: [NSLocalizedDescriptionKey: "plain"])
        let error = NSError(domain: "TestDomain",
                            code: 1,
                            userInfo: [NSUnderlyingErrorKey: underlying])

        #expect(error.cause != nil)
    }

    @Test
    func test_cause_present() {
        let underlyingError = NSError(domain: "InnerDomain",
                                      code: 1,
                                      userInfo: [NSLocalizedDescriptionKey: "Inner error"])
        let error = NSError(domain: "OuterDomain",
                            code: 2,
                            userInfo: [NSUnderlyingErrorKey: underlyingError])

        #expect(error.cause?.message == "Inner error")
    }

    @Test
    func test_message() {
        let error = NSError(domain: "TestDomain",
                            code: 42,
                            userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])

        #expect(error.message == "Something went wrong")
    }
}
