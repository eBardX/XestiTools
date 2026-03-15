// © 2023–2026 John Gary Pusey (see LICENSE.md)

#if compiler(>=6)
import _Builtin_stdatomic
#else
import Darwin
#endif

/// A thin wrapper around the `atomic_flag` C structure type and its associated
/// operations.
public struct AtomicFlag {

    // MARK: Public Initializers

    /// Creates a new `AtomicFlag` instance.
    public init() {
        self.flag = atomic_flag()
    }

    // MARK: Public Instance Methods

    /// Atomically places this flag into the _clear_ state.
    public mutating func clear() {
        atomic_flag_clear(&flag)
    }

    /// Atomically places this flag into the _set_ state and returns the
    /// immediately preceding state.
    ///
    /// - Returns:  `true` if this flag was previously in the _set_ state;
    ///             `false` if this flag was previously in the _clear_ state.
    public mutating func testAndSet() -> Bool {
        atomic_flag_test_and_set(&flag)
    }

    // MARK: Private Instance Properties

    private var flag: atomic_flag
}

// MARK: - Sendable

extension AtomicFlag: Sendable {
}
