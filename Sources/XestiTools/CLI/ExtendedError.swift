// © 2018–2026 John Gary Pusey (see LICENSE.md)

private import ArgumentParser
private import XestiText

/// An error with extended information.
///
/// An extended error also provides formatting capabilities intended for use by
/// command-line tools.
public protocol ExtendedError: EnhancedError, CustomStringConvertible {
    /// The `ExitCode` value associated with this error. Defaults to `.failure`.
    var exitCode: ExitCode { get }

    /// An array of strings providing hints as to the nature of this error.
    /// Defaults to an array of messages from the nested causes of this error.
    var hints: [String] { get }

    /// The string with which to prefix each hint in ``hints`` when formatting
    /// this error for display.
    var hintsPrefix: String { get }

    /// The string with which to prefix `message` when formatting this error for
    /// display.
    var messagePrefix: String { get }
}

// MARK: - (defaults)

extension ExtendedError {

    // MARK: Public Instance Properties

    public var description: String {
        let totalWidth = Formatter.terminalWidth()

        var text = Formatter.hangIndent(prefix: messagePrefix,
                                        text: message,
                                        totalWidth: totalWidth)

        text = String(text.dropFirst(messagePrefix.count))

        for hint in hints {
            text += "\n"
            text += Formatter.hangIndent(prefix: hintsPrefix,
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

    public var messagePrefix: String {
        "Error: "
    }
}
