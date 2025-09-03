import XCTest
@testable import XestiTools

internal class NSNumberExtensionsTests: XCTestCase {
}

// MARK: -

extension NSNumberExtensionsTests {
    func test_matches() {
        XCTAssertTrue(NSNumber(value: false).isBoolean)
        XCTAssertTrue(NSNumber(value: true).isBoolean)
        XCTAssertFalse(NSNumber(value: 0).isBoolean)
        XCTAssertFalse(NSNumber(value: -123456).isBoolean)
        XCTAssertFalse(NSNumber(value: 12345.6789).isBoolean)
    }
}
