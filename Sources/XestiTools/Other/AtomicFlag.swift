// © 2023–2025 John Gary Pusey (see LICENSE.md)

#if compiler(>=6)
import _Builtin_stdatomic
#else
import Darwin
#endif

public struct AtomicFlag {

    // MARK: Public Initializers

    public init() {
        self.flag = atomic_flag()
    }

    // MARK: Public Instance Methods

    public mutating func clear() {
        atomic_flag_clear(&flag)
    }

    public mutating func testAndSet() -> Bool {
        atomic_flag_test_and_set(&flag)
    }

    // MARK: Private Instance Properties

    private var flag: atomic_flag
}

// MARK: - Sendable

extension AtomicFlag: Sendable {
}
