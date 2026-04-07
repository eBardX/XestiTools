// © 2018–2026 John Gary Pusey (see LICENSE.md)

private import ArgumentParser

/// An error with extended information.
///
/// An extended error provides additional properties intended for use when
/// formatting errors for display in command-line tools.
public protocol ExtendedError: EnhancedError {
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
