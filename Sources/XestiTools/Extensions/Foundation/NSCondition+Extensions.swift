// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation

extension NSCondition {

    // MARK: Public Initializers

    /// Creates a new `NSCondition` instance associated with the provided name.
    ///
    /// - Parameter name:   The name to associate with the new condition.
    public convenience init(named name: String) {
        self.init()

        self.name = name
    }
}
