// © 2020–2024 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import System

// MARK: - ExpressibleByArgument

extension FilePath: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(argument)
    }
}
