// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A verbosity level (for example, to indicate tracing detail).
public enum Verbosity: Int {
    /// Silent — nothing or nearly so.
    case silent = 0

    /// Quiet — only essential information.
    case quiet = 1

    /// Verbose — loquacious but tolerable.
    case verbose = 2

    /// Very verbose — serious logorrhea.
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
}

// MARK: - Sendable

extension Verbosity: Sendable {
}
