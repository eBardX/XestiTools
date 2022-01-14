// © 2020–2022 J. G. Pusey (see LICENSE.md)

import ArgumentParser
import CoreFoundation
import Dispatch

public struct CommandRunner<Command: ParsableCommand> {

    // MARK: Public Type Methods

    public static func run() {
        DispatchQueue.global().async {
            do {
                var command = try Command.parseAsRoot()

                try command.run()
            } catch {
                guard
                    let extError = error as? ExtendedError
                    else { Command.exit(withError: error) }

                qprintError("\(extError.messagePrefix)\(extError)")

                Darwin.exit(extError.exitCode.rawValue)
            }

            Darwin.exit(ExitCode.success.rawValue)
        }

        CFRunLoopRun()
    }
}
