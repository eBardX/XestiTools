// © 2023–2026 John Gary Pusey (see LICENSE.md)

public import CoreGraphics

// MARK: - Comparable

extension CGPoint: @retroactive Comparable {
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
