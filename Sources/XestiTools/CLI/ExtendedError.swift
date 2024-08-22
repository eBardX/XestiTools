// © 2018–2024 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import XestiText

public protocol ExtendedError: EnhancedError, CustomStringConvertible {
    var exitCode: ExitCode { get }
    var hints: [String] { get }
    var hintsPrefix: String { get }
    var message: String { get }
    var messagePrefix: String { get }
}

// MARK: - (defaults)

extension ExtendedError {

    // MARK: Public Instance Properties

    public var description: String {
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

    public var exitCode: ExitCode {
        .failure
    }

    public var hints: [String] {
        var tmpError = self as any EnhancedError
        var tmpHints: [String] = []

        while let tmpCause = tmpError.cause {
            tmpHints.append(tmpCause.message)

            tmpError = tmpCause
        }

        return tmpHints
    }

    public var hintsPrefix: String {
        "     - "
    }

    public var localizedDescription: String {
        description
    }

    public var messagePrefix: String {
        "Error: "
    }
}
