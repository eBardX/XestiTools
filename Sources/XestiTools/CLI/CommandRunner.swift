// © 2020–2024 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import CoreFoundation

public enum CommandRunner<Command: ParsableCommand> {

    // MARK: Public Type Methods

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
