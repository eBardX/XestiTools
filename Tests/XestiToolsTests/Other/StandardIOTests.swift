// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
import XestiTools

struct StandardIOTests {
}

// MARK: -

extension StandardIOTests {
    @Test
    func init_defaults() {
        let standardIO = StandardIO()

        #expect(standardIO.standardInput.value as? FileHandle === FileHandle.standardInput)
        #expect(standardIO.standardOutput.value as? FileHandle === FileHandle.standardOutput)
        #expect(standardIO.standardError.value as? FileHandle === FileHandle.standardError)
        #expect(standardIO.timestampFormatter == nil)
    }

    @Test
    func redirect_throwsForMissingInputFile() {
        let standardIO = StandardIO()
        let missingPath = FilePath.uniqueTemporaryDirectory.appending("missing.txt")

        #expect(throws: (any Error).self) {
            try standardIO.redirect(standardInput: missingPath)
        }
    }

    @Test
    func redirect_toOutputFile() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let outputPath = dir.appending("out.txt")
        let standardIO = StandardIO()
        let redirected = try standardIO.redirect(standardOutput: outputPath)

        redirected.writeOutput("redirected")

        let contents = try RunLoop.waitForValue(timeout: 1.0,
                                                interval: 0.02) { () -> Data? in
            let data = try? outputPath.readData()

            return (data?.isEmpty == false) ? data : nil
        }

        #expect(String(data: contents, encoding: .utf8) == "redirected\n")
    }

    @Test
    func writeError_data() throws {
        // `writeError` synchronizes `standardOutput` before writing to
        // `standardError`, so `standardOutput` must be backed by a regular
        // file (a pipe's write end doesn't support `synchronize()`).
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let outputHandle = try makeWritableFileHandle(in: dir)
        let errorPipe = Pipe()
        let standardIO = StandardIO(standardOutput: .file(outputHandle),
                                    standardError: .pipe(errorPipe))

        standardIO.writeError(Data("oops".utf8))

        let data = readAvailableData(from: errorPipe)

        #expect(String(data: data, encoding: .utf8) == "oops")
    }

    @Test
    func writeError_message() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let outputHandle = try makeWritableFileHandle(in: dir)
        let errorPipe = Pipe()
        let standardIO = StandardIO(standardOutput: .file(outputHandle),
                                    standardError: .pipe(errorPipe))

        standardIO.writeError("oops")

        let data = readAvailableData(from: errorPipe)

        #expect(String(data: data, encoding: .utf8) == "oops\n")
    }

    @Test
    func writeOutput_customTerminator() {
        let outputPipe = Pipe()
        let standardIO = StandardIO(standardOutput: .pipe(outputPipe),
                                    standardError: .pipe(Pipe()))

        standardIO.writeOutput("hello", "!")

        let data = readAvailableData(from: outputPipe)

        #expect(String(data: data, encoding: .utf8) == "hello!")
    }

    @Test
    func writeOutput_data() {
        let outputPipe = Pipe()
        let standardIO = StandardIO(standardOutput: .pipe(outputPipe),
                                    standardError: .pipe(Pipe()))

        standardIO.writeOutput(Data("hello".utf8))

        let data = readAvailableData(from: outputPipe)

        #expect(String(data: data, encoding: .utf8) == "hello")
    }

    @Test
    func writeOutput_message() {
        let outputPipe = Pipe()
        let standardIO = StandardIO(standardOutput: .pipe(outputPipe),
                                    standardError: .pipe(Pipe()))

        standardIO.writeOutput("hello")

        let data = readAvailableData(from: outputPipe)

        #expect(String(data: data, encoding: .utf8) == "hello\n")
    }

    @Test
    func writeOutput_withTimestampFormatter() throws {
        let outputPipe = Pipe()
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy"

        let standardIO = StandardIO(standardOutput: .pipe(outputPipe),
                                    standardError: .pipe(Pipe()),
                                    timestampFormatter: formatter)
        let year = formatter.string(from: Date())

        standardIO.writeOutput("hello")

        let data = readAvailableData(from: outputPipe)
        let output = try #require(String(data: data, encoding: .utf8))

        #expect(output == "\(year) hello\n")
    }
}
