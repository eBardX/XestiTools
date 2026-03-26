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
    func test_allDistinctValues() {
        let codes: [ExitCode] = [
            .configurationError,
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
            .usageError
        ]

        let uniqueRawValues = Set(codes.map(\.rawValue))

        #expect(uniqueRawValues.count == codes.count)
    }

    @Test
    func test_configurationError() {
        #expect(ExitCode.configurationError.rawValue == EX_CONFIG)
    }

    @Test
    func test_dataFormatError() {
        #expect(ExitCode.dataFormatError.rawValue == EX_DATAERR)
    }

    @Test
    func test_inputOpenFailure() {
        #expect(ExitCode.inputOpenFailure.rawValue == EX_NOINPUT)
    }

    @Test
    func test_internalSoftwareError() {
        #expect(ExitCode.internalSoftwareError.rawValue == EX_SOFTWARE)
    }

    @Test
    func test_ioError() {
        #expect(ExitCode.ioError.rawValue == EX_IOERR)
    }

    @Test
    func test_missingSystemFile() {
        #expect(ExitCode.missingSystemFile.rawValue == EX_OSFILE)
    }

    @Test
    func test_outputCreateFailure() {
        #expect(ExitCode.outputCreateFailure.rawValue == EX_CANTCREAT)
    }

    @Test
    func test_permissionDenied() {
        #expect(ExitCode.permissionDenied.rawValue == EX_NOPERM)
    }

    @Test
    func test_remoteProtocolError() {
        #expect(ExitCode.remoteProtocolError.rawValue == EX_PROTOCOL)
    }

    @Test
    func test_serviceUnavailable() {
        #expect(ExitCode.serviceUnavailable.rawValue == EX_UNAVAILABLE)
    }

    @Test
    func test_systemError() {
        #expect(ExitCode.systemError.rawValue == EX_OSERR)
    }

    @Test
    func test_temporaryFailure() {
        #expect(ExitCode.temporaryFailure.rawValue == EX_TEMPFAIL)
    }

    @Test
    func test_unknownHost() {
        #expect(ExitCode.unknownHost.rawValue == EX_NOHOST)
    }

    @Test
    func test_unknownUser() {
        #expect(ExitCode.unknownUser.rawValue == EX_NOUSER)
    }

    @Test
    func test_usageError() {
        #expect(ExitCode.usageError.rawValue == EX_USAGE)
    }
}
