// © 2020–2026 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import Foundation

// MARK: - ExpressibleByArgument

extension URL {
    /// Creates a new URL instance from the specified command-line argument.
    ///
    /// - Parameter argument:   The command-line argument.
    public init?(argument: String) {
        self.init(string: argument)
    }
}

#if compiler(>=6)
extension URL: @retroactive ExpressibleByArgument {}
#else
extension URL: ExpressibleByArgument {}
#endif
