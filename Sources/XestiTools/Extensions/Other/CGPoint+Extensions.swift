// © 2023–2025 John Gary Pusey (see LICENSE.md)

import CoreGraphics

extension CGPoint {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        if lhs.x < rhs.x {
            return true
        }

        if lhs.x > rhs.x {
            return false
        }

        return lhs.y < rhs.y
    }
}

#if compiler(>=6)
extension CGPoint: @retroactive Comparable {}
#else
extension CGPoint: Comparable {}
#endif
