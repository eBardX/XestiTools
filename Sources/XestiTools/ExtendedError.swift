// © 2018–2020 J. G. Pusey (see LICENSE.md)

import ArgumentParser
import XestiText

public protocol ExtendedError: Error, CustomStringConvertible {
    var exitCode: ExitCode { get }
    var hints: [String] { get }
    var hintsPrefix: String { get }
    var message: String { get }
    var messagePrefix: String { get }
}

// MARK: -

public extension ExtendedError {

    // MARK: Public Instance Properties

    var description: String {
        let totalWidth = Format.terminalWidth()

        var text = Format.hangIndent(prefix: messagePrefix,
                                     text: message,
                                     totalWidth: totalWidth)

        text = String(text.dropFirst(messagePrefix.count))

        for hint in hints {
            text += "\n"
            text += Format.hangIndent(prefix: hintsPrefix,
                                      text: hint,
                                      totalWidth: totalWidth)
        }

        return text
    }

    var exitCode: ExitCode {
        .failure
    }

    var hints: [String] {
        []
    }

    var hintsPrefix: String {
        "     - "
    }

    var localizedDescription: String {
        description
    }

    var messagePrefix: String {
        "Error: "
    }
}
