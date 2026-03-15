// © 2020–2026 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import System

// MARK: - ExpressibleByArgument

extension FilePath {
    /// Creates a new file path instance from the specified command-line
    /// argument.
    ///
    /// - Parameter argument:   The command-line argument.
    public init?(argument: String) {
        self.init(argument)
    }
}

#if compiler(>=6)
extension FilePath: @retroactive ExpressibleByArgument {}
#else
extension FilePath: ExpressibleByArgument {}
#endif
