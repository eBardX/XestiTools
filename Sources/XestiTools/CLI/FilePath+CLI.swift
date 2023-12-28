// © 2020–2023 J. G. Pusey (see LICENSE.md)

import ArgumentParser
import System

// MARK: - ExpressibleByArgument

extension FilePath: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(argument)
    }
}
