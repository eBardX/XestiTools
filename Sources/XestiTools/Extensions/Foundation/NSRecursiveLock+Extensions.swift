// © 2023–2026 John Gary Pusey (see LICENSE.md)

import Foundation

extension NSRecursiveLock {

    // MARK: Public Initializers

    public convenience init(named name: String) {
        self.init()

        self.name = name
    }
}
