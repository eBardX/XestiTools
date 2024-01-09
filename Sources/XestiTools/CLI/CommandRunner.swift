// © 2020–2024 J. G. Pusey (see LICENSE.md)

import ArgumentParser
import CoreFoundation
import Dispatch

public enum CommandRunner<Command: ParsableCommand> {

    // MARK: Public Type Methods

    public static func run(useGCD: Bool = false) {
        DispatchQueue.global().async {
            do {
                var command = try Command.parseAsRoot()

                try command.run()
            } catch {
                guard let extError = error as? (any ExtendedError)
                else { Command.exit(withError: error) }

                qprintError("\(extError.messagePrefix)\(extError)")

                Darwin.exit(extError.exitCode.rawValue)
            }

            Darwin.exit(ExitCode.success.rawValue)
        }

        if useGCD {
            dispatchMain()
        } else {
            CFRunLoopRun()
        }
    }
}
