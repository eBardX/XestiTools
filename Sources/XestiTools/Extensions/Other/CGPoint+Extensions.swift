// © 2023–2025 John Gary Pusey (see LICENSE.md)

import CoreGraphics

extension CGPoint: @retroactive Comparable {
    public static func < (lhs: CGPoint,
                          rhs: CGPoint) -> Bool {
        if lhs.x < rhs.x {
            return true
        }

        if lhs.x > rhs.x {
            return false
        }

        return lhs.y < rhs.y
    }
}
