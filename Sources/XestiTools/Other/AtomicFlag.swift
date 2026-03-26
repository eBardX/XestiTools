// © 2023–2026 John Gary Pusey (see LICENSE.md)

#if compiler(>=6)
private import _Builtin_stdatomic
#else
private import Darwin
#endif

/// A thin wrapper around the `atomic_flag` C structure type and its associated
/// operations.
///
/// Although `AtomicFlag` is a value type, it uses reference semantics
/// internally so that copies share the same underlying flag. This ensures
/// that passing or capturing an `AtomicFlag` preserves synchronization.
public struct AtomicFlag {

    // MARK: Public Initializers

    /// Creates a new `AtomicFlag` instance.
    public init() {
        self.storage = Storage()
    }

    // MARK: Public Instance Methods

    /// Atomically places this flag into the _clear_ state.
    public mutating func clear() {
        atomic_flag_clear(storage.pointer)
    }

    /// Atomically places this flag into the _set_ state and returns the
    /// immediately preceding state.
    ///
    /// - Returns:  `true` if this flag was previously in the _set_ state;
    ///             `false` if this flag was previously in the _clear_ state.
    public mutating func testAndSet() -> Bool {
        atomic_flag_test_and_set(storage.pointer)
    }

    // MARK: Private Instance Properties

    private let storage: Storage
}

// MARK: -

extension AtomicFlag {

    // MARK: Private Nested Types

    private final class Storage: @unchecked Sendable {
        init() {
            self.pointer = .allocate(capacity: 1)
            self.pointer.initialize(to: atomic_flag())
        }

        deinit {
            pointer.deinitialize(count: 1)
            pointer.deallocate()
        }

        let pointer: UnsafeMutablePointer<atomic_flag>
    }
}

// MARK: - Sendable

extension AtomicFlag: Sendable {
}
