// © 2023–2024 John Gary Pusey (see LICENSE.md)

import Darwin

public class AtomicFlag {

    // MARK: Public Initializers

    public init() {
        self.flag = atomic_flag()
    }

    // MARK: Public Instance Methods

    public func clear() {
        atomic_flag_clear(&flag)
    }

    public func testAndSet() -> Bool {
        atomic_flag_test_and_set(&flag)
    }

    // MARK: Private Instance Properties

    private var flag: atomic_flag
}
