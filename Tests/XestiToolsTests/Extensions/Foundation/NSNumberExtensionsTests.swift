// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct NSNumberExtensionsTests {
}

// MARK: -

extension NSNumberExtensionsTests {
    @Test
    func test_matches() {
        #expect(NSNumber(value: false).isBoolean)
        #expect(NSNumber(value: true).isBoolean)
        #expect(!NSNumber(value: 0).isBoolean)
        #expect(!NSNumber(value: -123_456).isBoolean)
        #expect(!NSNumber(value: 12_345.6789).isBoolean)
    }
}
