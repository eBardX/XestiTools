// © 2020–2024 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import Darwin.sysexits

extension ExitCode {
    public static let configurationError = ExitCode(EX_CONFIG)
    public static let dataFormatError = ExitCode(EX_DATAERR)
    public static let inputOpenFailure = ExitCode(EX_NOINPUT)
    public static let internalSoftwareError = ExitCode(EX_SOFTWARE)
    public static let ioError = ExitCode(EX_IOERR)
    public static let missingSystemFile = ExitCode(EX_OSFILE)
    public static let outputCreateFailure = ExitCode(EX_CANTCREAT)
    public static let permissionDenied = ExitCode(EX_NOPERM)
    public static let remoteProtocolError = ExitCode(EX_PROTOCOL)
    public static let serviceUnavailable = ExitCode(EX_UNAVAILABLE)
    public static let systemError = ExitCode(EX_OSERR)
    public static let temporaryFailure = ExitCode(EX_TEMPFAIL)
    public static let unknownHost = ExitCode(EX_NOHOST)
    public static let unknownUser = ExitCode(EX_NOUSER)
    public static let usageError = ExitCode(EX_USAGE)
}
