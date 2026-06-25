// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension NSLock {

    // MARK: Public Initializers

    /// Creates a new `NSLock` instance associated with the provided name.
    ///
    /// - Parameter name:   The name to associate with the new lock.
    public convenience init(named name: String) {
        self.init()

        self.name = name
    }
}
