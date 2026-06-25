// © 2023–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension NSRecursiveLock {

    // MARK: Public Initializers

    /// Creates a new `NSRecursiveLock` instance associated with the provided
    /// name.
    ///
    /// - Parameter name:   The name to associate with the new recursive lock.
    public convenience init(named name: String) {
        self.init()

        self.name = name
    }
}
