// © 2023 J. G. Pusey (see LICENSE.md)

import Foundation

extension NSRecursiveLock {

    // MARK: Public Initializers

    public convenience init(named name: String) {
        self.init()

        self.name = name
    }
}
