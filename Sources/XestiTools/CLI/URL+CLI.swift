// © 2020–2024 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import Foundation

// MARK: - ExpressibleByArgument

extension URL: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(string: argument)
    }
}
