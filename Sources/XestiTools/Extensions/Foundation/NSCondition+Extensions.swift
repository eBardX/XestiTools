// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension NSCondition {

    // MARK: Public Initializers

    public convenience init(named name: String) {
        self.init()

        self.name = name
    }
}
