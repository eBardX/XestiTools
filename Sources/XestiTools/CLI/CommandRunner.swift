// © 2020–2026 John Gary Pusey (see LICENSE.md)

private import ArgumentParser
private import CoreFoundation

/// A generic command runner that can run synchronous commands only.
public enum CommandRunner<Command: ParsableCommand> {

    // MARK: Public Type Methods

    /// Parses an instance of the `Command` type, or one of its subcommands,
    /// from the program’s command-line arguments, and then runs it.
    public static func run() {
        DispatchQueue.global().async {
            do {
                var command = try Command.parseAsRoot()

                try command.run()
            } catch {
                guard let extError = error as? (any ExtendedError)
                else { Command.exit(withError: error) }

                StandardIO().writeError("\(extError.messagePrefix)\(extError)")

                Darwin.exit(extError.exitCode.rawValue)
            }

            Darwin.exit(ExitCode.success.rawValue)
        }

        CFRunLoopRun()
    }
}
