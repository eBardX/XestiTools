// © 2025 John Gary Pusey (see LICENSE.md)

public enum Verbosity: Int {
    case silent      = 0
    case quiet       = 1
    case verbose     = 2
    case veryVerbose = 3
}

// MARK: - Comparable

extension Verbosity: Comparable {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Equatable

extension Verbosity: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
