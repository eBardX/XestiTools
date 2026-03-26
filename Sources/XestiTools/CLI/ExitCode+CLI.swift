// © 2020–2026 John Gary Pusey (see LICENSE.md)

private import ArgumentParser
private import Darwin.sysexits

extension ExitCode {

    // MARK: Public Type Properties

    /// Something was found in an unconfigured or misconfigured state.
    /// (`EX_CONFIG`)
    public static let configurationError = ExitCode(EX_CONFIG)

    /// The input data was incorrect in some way. (`EX_DATAERR`)
    public static let dataFormatError = ExitCode(EX_DATAERR)

    /// An input file (not a system file) did not exist or was not readable.
    /// (`EX_NOINPUT`)
    public static let inputOpenFailure = ExitCode(EX_NOINPUT)

    /// An internal software error has been detected. (`EX_SOFTWARE`)
    public static let internalSoftwareError = ExitCode(EX_SOFTWARE)

    /// An error occurred while doing I/O on some file. (`EX_IOERR`)
    public static let ioError = ExitCode(EX_IOERR)

    /// Some system file does not exist, cannot be opened, or has some sort of
    /// error. (`EX_OSFILE`)
    public static let missingSystemFile = ExitCode(EX_OSFILE)

    /// A (user specified) output file cannot be created. (`EX_CANTCREAT`)
    public static let outputCreateFailure = ExitCode(EX_CANTCREAT)

    /// You did not have sufficient permission to perform the operation.
    /// (`EX_NOPERM`)
    public static let permissionDenied = ExitCode(EX_NOPERM)

    /// The remote system returned something that was “not possible” during a
    /// protocol exchange. (`EX_PROTOCOL`)
    public static let remoteProtocolError = ExitCode(EX_PROTOCOL)

    /// A service is unavailable. (`EX_UNAVAILABLE`)
    public static let serviceUnavailable = ExitCode(EX_UNAVAILABLE)

    /// An operating system error has been detected. (`EX_OSERR`)
    public static let systemError = ExitCode(EX_OSERR)

    /// Temporary failure, indicating something that is not really an error.
    /// (`EX_TEMPFAIL`)
    public static let temporaryFailure = ExitCode(EX_TEMPFAIL)

    /// The host specified did not exist. (`EX_NOHOST`)
    public static let unknownHost = ExitCode(EX_NOHOST)

    /// The user specified did not exist. (`EX_NOUSER`)
    public static let unknownUser = ExitCode(EX_NOUSER)

    /// The command was used incorrectly. (`EX_USAGE`)
    public static let usageError = ExitCode(EX_USAGE)
}
