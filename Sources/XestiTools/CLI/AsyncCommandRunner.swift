// © 2024 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import CoreFoundation

public enum AsyncCommandRunner<Command: AsyncParsableCommand> {

    // MARK: Public Type Methods

    public static func run() async {
        do {
            var command = try Command.parseAsRoot()

            if var asyncCommand = command as? (any AsyncParsableCommand) {
                try await asyncCommand.run()
            } else {
                try command.run()
            }
        } catch {
            guard let extError = error as? (any ExtendedError)
            else { Command.exit(withError: error) }

            StandardIO().writeError("\(extError.messagePrefix)\(extError)")

            Darwin.exit(extError.exitCode.rawValue)
        }

        Darwin.exit(ExitCode.success.rawValue)
    }
}
