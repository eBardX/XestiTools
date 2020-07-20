// © 2020 J. G. Pusey (see LICENSE.md)

import ArgumentParser
import Darwin.sysexits

public extension ExitCode {
    static let configurationError = ExitCode(EX_CONFIG)
    static let dataFormatError = ExitCode(EX_DATAERR)
    static let inputOpenFailure = ExitCode(EX_NOINPUT)
    static let internalSoftwareError = ExitCode(EX_SOFTWARE)
    static let ioError = ExitCode(EX_IOERR)
    static let missingSystemFile = ExitCode(EX_OSFILE)
    static let outputCreateFailure = ExitCode(EX_CANTCREAT)
    static let permissionDenied = ExitCode(EX_NOPERM)
    static let remoteProtocolError = ExitCode(EX_PROTOCOL)
    static let serviceUnavailable = ExitCode(EX_UNAVAILABLE)
    static let systemError = ExitCode(EX_OSERR)
    static let temporaryFailure = ExitCode(EX_TEMPFAIL)
    static let unknownHost = ExitCode(EX_NOHOST)
    static let unknownUser = ExitCode(EX_NOUSER)
    static let usageError = ExitCode(EX_USAGE)
}
