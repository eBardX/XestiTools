// © 2025–2026 John Gary Pusey (see LICENSE.md)

import CoreGraphics
import Testing
 import XestiToolsCore

struct CGPointExtensionsTests {
}

// MARK: -

extension CGPointExtensionsTests {
    @Test
    func comparable_equalPoints() {
        let lhs = CGPoint(x: 1, y: 2)
        let rhs = CGPoint(x: 1, y: 2)

        #expect(!(lhs < rhs))
        #expect(!(rhs < lhs))
    }

    @Test
    func comparable_lessThanByX() {
        let lhs = CGPoint(x: 1, y: 5)
        let rhs = CGPoint(x: 2, y: 3)

        #expect(lhs < rhs)
        #expect(!(rhs < lhs))
    }

    @Test
    func comparable_lessThanByYWhenXEqual() {
        let lhs = CGPoint(x: 1, y: 2)
        let rhs = CGPoint(x: 1, y: 3)

        #expect(lhs < rhs)
        #expect(!(rhs < lhs))
    }

    @Test
    func comparable_lessThanGreaterXButLessY() {
        let lhs = CGPoint(x: 5, y: 1)
        let rhs = CGPoint(x: 3, y: 10)

        #expect(!(lhs < rhs))
        #expect(rhs < lhs)
    }

    @Test
    func comparable_negativePoints() {
        let lhs = CGPoint(x: -2, y: -1)
        let rhs = CGPoint(x: -1, y: -2)

        #expect(lhs < rhs)
    }

    @Test
    func comparable_zeroPoint() {
        let zero = CGPoint.zero
        let positive = CGPoint(x: 1, y: 1)

        #expect(zero < positive)
    }
}
