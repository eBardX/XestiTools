// © 2020–2026 John Gary Pusey (see LICENSE.md)

public import ArgumentParser
public import System

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

extension FilePath: @retroactive ExpressibleByArgument {
}
