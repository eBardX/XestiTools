// © 2020–2025 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import Foundation

// MARK: - ExpressibleByArgument

extension URL: @retroactive ExpressibleByArgument {
    public init?(argument: String) {
        self.init(string: argument)
    }
}
