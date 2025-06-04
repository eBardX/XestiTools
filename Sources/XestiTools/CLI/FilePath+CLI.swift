// © 2020–2025 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import System

// MARK: - ExpressibleByArgument

extension FilePath {
    public init?(argument: String) {
        self.init(argument)
    }
}

#if compiler(>=6)
extension FilePath: @retroactive ExpressibleByArgument {}
#else
extension FilePath: ExpressibleByArgument {}
#endif
