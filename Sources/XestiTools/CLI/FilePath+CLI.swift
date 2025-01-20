// © 2020–2025 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import System

// MARK: - ExpressibleByArgument

extension FilePath: @retroactive ExpressibleByArgument {
    public init?(argument: String) {
        self.init(argument)
    }
}
