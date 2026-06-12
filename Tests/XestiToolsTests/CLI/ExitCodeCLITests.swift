// © 2025–2026 John Gary Pusey (see LICENSE.md)

import ArgumentParser
import Darwin.sysexits
import Testing
@testable import XestiTools

struct ExitCodeCLITests {
}

// MARK: -

extension ExitCodeCLITests {
    @Test
    func allDistinctValues() {
        let codes: [ExitCode] = [.configurationError,
                                 .dataFormatError,
                                 .inputOpenFailure,
                                 .internalSoftwareError,
                                 .ioError,
                                 .missingSystemFile,
                                 .outputCreateFailure,
                                 .permissionDenied,
                                 .remoteProtocolError,
                                 .serviceUnavailable,
                                 .systemError,
                                 .temporaryFailure,
                                 .unknownHost,
                                 .unknownUser,
                                 .usageError]

        let uniqueRawValues = Set(codes.map(\.rawValue))

        #expect(uniqueRawValues.count == codes.count)
    }

    @Test
    func configurationError() {
        #expect(ExitCode.configurationError.rawValue == EX_CONFIG)
    }

    @Test
    func dataFormatError() {
        #expect(ExitCode.dataFormatError.rawValue == EX_DATAERR)
    }

    @Test
    func inputOpenFailure() {
        #expect(ExitCode.inputOpenFailure.rawValue == EX_NOINPUT)
    }

    @Test
    func internalSoftwareError() {
        #expect(ExitCode.internalSoftwareError.rawValue == EX_SOFTWARE)
    }

    @Test
    func ioError() {
        #expect(ExitCode.ioError.rawValue == EX_IOERR)
    }

    @Test
    func missingSystemFile() {
        #expect(ExitCode.missingSystemFile.rawValue == EX_OSFILE)
    }

    @Test
    func outputCreateFailure() {
        #expect(ExitCode.outputCreateFailure.rawValue == EX_CANTCREAT)
    }

    @Test
    func permissionDenied() {
        #expect(ExitCode.permissionDenied.rawValue == EX_NOPERM)
    }

    @Test
    func remoteProtocolError() {
        #expect(ExitCode.remoteProtocolError.rawValue == EX_PROTOCOL)
    }

    @Test
    func serviceUnavailable() {
        #expect(ExitCode.serviceUnavailable.rawValue == EX_UNAVAILABLE)
    }

    @Test
    func systemError() {
        #expect(ExitCode.systemError.rawValue == EX_OSERR)
    }

    @Test
    func temporaryFailure() {
        #expect(ExitCode.temporaryFailure.rawValue == EX_TEMPFAIL)
    }

    @Test
    func unknownHost() {
        #expect(ExitCode.unknownHost.rawValue == EX_NOHOST)
    }

    @Test
    func unknownUser() {
        #expect(ExitCode.unknownUser.rawValue == EX_NOUSER)
    }

    @Test
    func usageError() {
        #expect(ExitCode.usageError.rawValue == EX_USAGE)
    }
}
