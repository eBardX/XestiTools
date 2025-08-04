// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension NSLock {

    // MARK: Public Initializers

    public convenience init(named name: String) {
        self.init()

        self.name = name
    }
}
