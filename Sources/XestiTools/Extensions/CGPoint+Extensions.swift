// © 2023 J. G. Pusey (see LICENSE.md)

import CoreGraphics

extension CGPoint: Comparable {
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
