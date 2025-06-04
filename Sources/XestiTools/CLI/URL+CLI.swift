// © 2020–2025 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import Foundation

// MARK: - ExpressibleByArgument

extension URL {
    public init?(argument: String) {
        self.init(string: argument)
    }
}

#if compiler(>=6)
extension URL: @retroactive ExpressibleByArgument {}
#else
extension URL: ExpressibleByArgument {}
#endif
