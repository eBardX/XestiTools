// © 2020–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

private import ArgumentParser

// MARK: - ExpressibleByArgument

extension URL {
    /// Creates a new URL instance from the specified command-line argument.
    ///
    /// - Parameter argument:   The command-line argument.
    public init?(argument: String) {
        guard !argument.isEmpty
        else { return nil }

        if let url = URL(string: argument) {
            self = url
        } else {
            self.init(fileURLWithPath: argument)
        }
    }
}

#if compiler(>=6)
extension URL: @retroactive ExpressibleByArgument {}
#else
extension URL: ExpressibleByArgument {}
#endif
