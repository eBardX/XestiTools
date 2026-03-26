// © 2025–2026 John Gary Pusey (see LICENSE.md)

import CoreGraphics
import Testing
@testable import XestiTools

struct CGRectExtensionsTests {
}

// MARK: -

extension CGRectExtensionsTests {
    @Test
    func test_center() {
        let rect = CGRect(x: 10, y: 20, width: 100, height: 200)

        #expect(rect.center.x == 60)
        #expect(rect.center.y == 120)
    }

    @Test
    func test_centerOfOriginRect() {
        let rect = CGRect(x: 0, y: 0, width: 50, height: 50)

        #expect(rect.center.x == 25)
        #expect(rect.center.y == 25)
    }

    @Test
    func test_centerOfZeroRect() {
        let rect = CGRect.zero

        #expect(rect.center.x == 0)
        #expect(rect.center.y == 0)
    }

    @Test
    func test_integerRounded() {
        let rect = CGRect(x: 1.4, y: 2.6, width: 8.6, height: 7.4)
        let rounded = rect.integerRounded

        #expect(rounded.origin.x == 1)
        #expect(rounded.origin.y == 3)
        #expect(rounded.size.width == 9)
        #expect(rounded.size.height == 7)
    }

    @Test
    func test_integerRoundedAlreadyInteger() {
        let rect = CGRect(x: 1, y: 2, width: 3, height: 4)
        let rounded = rect.integerRounded

        #expect(rounded.origin.x == 1)
        #expect(rounded.origin.y == 2)
        #expect(rounded.size.width == 3)
        #expect(rounded.size.height == 4)
    }

    @Test
    func test_integerRoundedHalfValues() {
        let rect = CGRect(x: 0.5, y: 1.5, width: 2.5, height: 3.5)
        let rounded = rect.integerRounded

        #expect(rounded.origin.x == 0 || rounded.origin.x == 1)
        #expect(rounded.size.width >= 2 && rounded.size.width <= 3)
    }

    @Test
    func test_integerRoundedNegativeValues() {
        let rect = CGRect(x: -1.6, y: -2.4, width: 5.6, height: 5.4)
        let rounded = rect.integerRounded

        #expect(rounded.origin.x == -2)
        #expect(rounded.origin.y == -2)
    }
}
