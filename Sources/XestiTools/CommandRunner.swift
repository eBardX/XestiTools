// © 2020 J. G. Pusey (see LICENSE.md)

import ArgumentParser
import CoreFoundation
import Dispatch

public struct CommandRunner<Command: ParsableCommand> {

    // MARK: Public Type Methods

    public static func run() {
        DispatchQueue.global().async {
            Command.main()
            Command.exit()
        }

        CFRunLoopRun()
    }
}
