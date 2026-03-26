// © 2024–2026 John Gary Pusey (see LICENSE.md)

@preconcurrency public import Foundation
public import System

private import Dispatch

/// Encapsulates standard input, standard output, and standard error into a
/// single, easy-to-use, immutable structure.
public struct StandardIO {

    // MARK: Public Initializers

    /// Creates a new `StandardIO` instance.
    ///
    /// - Parameter standardInput:      The file handle or pipe to use for
    ///                                 standard input. Defaults to the shared
    ///                                 file handle associated with the standard
    ///                                 input file.
    /// - Parameter standardOutput:     The file handle or pipe to use for
    ///                                 standard output. Defaults to the shared
    ///                                 file handle associated with the standard
    ///                                 output file.
    /// - Parameter standardError:      The file handle or pipe to use for
    ///                                 standard error. Defaults to the shared
    ///                                 file handle associated with the standard
    ///                                 error file.
    /// - Parameter timestampFormatter: An optional timestamp formatter.
    ///                                 Defaults to `nil`.
    public init(standardInput: FileOrPipe = .file(.standardInput),
                standardOutput: FileOrPipe = .file(.standardOutput),
                standardError: FileOrPipe = .file(.standardError),
                timestampFormatter: Formatter? = nil) {
        self.standardError = standardError
        self.standardInput = standardInput
        self.standardOutput = standardOutput
        self.syncQueue = Self._makeSyncQueue()
        self.timestampFormatter = timestampFormatter
    }

    // MARK: Public Instance Properties

    /// The file handle or pipe to use for standard error.
    public let standardError: FileOrPipe

    /// The file handle or pipe to use for standard input.
    public let standardInput: FileOrPipe

    /// The file handle or pipe to use for standard output.
    public let standardOutput: FileOrPipe

    /// The optional timestamp formatter.
    ///
    /// If `timestampFormatter` is not `nil`, ``writeOutput(_:_:)`` and
    /// ``writeError(_:_:)`` behave differently.
    public let timestampFormatter: Formatter?

    // MARK: Public Instance Methods

    /// Returns a string read from standard input through the end of the current
    /// line or until EOF is reached.
    ///
    /// Standard input is interpreted as UTF-8. Invalid bytes are replaced by
    /// Unicode replacement characters.
    ///
    /// - Parameter prompt: An optional string to write to standard output as a
    ///                     prompt. The prompt string is typically unterminated.
    ///
    /// - Returns:  The string of characters read from standard input. If EOF
    ///             has already been reached when ``readInput(_:)`` is called,
    ///             the result is `nil`.
    public func readInput(_ prompt: String?) -> String? {
        if let data = prompt?.data(using: .utf8) {
            syncQueue.sync {
                do {
                    try standardOutput.fileHandleForWriting.synchronize()
                    try standardOutput.fileHandleForWriting.write(contentsOf: data)
                } catch {
                }
            }
        }

        return readLine()
    }

    /// Creates a new `StandardIO` instance that redirects the original instance
    /// as provided.
    ///
    /// - Parameter inputPath:  An optional file location from which to redirect
    ///                         standard input. Defaults to `nil`.
    /// - Parameter outputPath: An optional file location to which to redirect
    ///                         standard output. Defaults to `nil`.
    /// - Parameter errorPath:  An optional file location to which to redirect
    ///                         standard error. Defaults to `nil`.
    ///
    /// - Returns:  The redirected `StandardIO` instance.
    public func redirect(standardInput inputPath: FilePath? = nil,
                         standardOutput outputPath: FilePath? = nil,
                         standardError errorPath: FilePath? = nil) throws -> Self {
        var stderr = self.standardError
        var stdout = self.standardOutput
        var stdin = self.standardInput

        if let inputPath {
            let fd = try FileDescriptor.open(inputPath,
                                             .readOnly,
                                             options: .nonBlocking,
                                             retryOnInterrupt: false)

            stdin = Self._makeFileHandle(fd)
        }

        if let outputPath {
            let fd = try FileDescriptor.open(outputPath,
                                             .writeOnly,
                                             options: [.create, .nonBlocking, .truncate],
                                             permissions: [.ownerReadWrite, .groupRead, .otherRead],
                                             retryOnInterrupt: false)

            stdout = Self._makeFileHandle(fd)
        }

        if let errorPath {
            let fd = try FileDescriptor.open(errorPath,
                                             .writeOnly,
                                             options: [.create, .nonBlocking, .truncate],
                                             permissions: [.ownerReadWrite, .groupRead, .otherRead],
                                             retryOnInterrupt: false)

            stderr = Self._makeFileHandle(fd)
        }

        return Self(standardInput: stdin,
                    standardOutput: stdout,
                    standardError: stderr)
    }

    /// Writes the provided data to standard error.
    ///
    /// - Parameter data:   The data to write to standard error.
    public func writeError(_ data: Data) {
        syncQueue.async {
            do {
                try standardOutput.fileHandleForWriting.synchronize()
                try standardError.fileHandleForWriting.write(contentsOf: data)
            } catch {
            }
        }
    }

    /// Writes the provided message and terminator strings to standard error.
    ///
    /// If ``timestampFormatter`` is not `nil`, the equivalent of the following
    /// is written to standard error:
    ///
    /// ```swift
    /// "\(timestamp) \(message)\(terminator)"
    /// ```
    ///
    /// Otherwise, the equivalent of the following is written to standard error:
    ///
    /// ```swift
    /// "\(message)\(terminator)"
    /// ```
    ///
    /// - Parameter message:    The message string to write to standard error.
    /// - Parameter terminator: The terminator string to write to standard error
    ///                         after the message string. The default is a
    ///                         newline (`"\n"`).
    public func writeError(_ message: String,
                           _ terminator: String = "\n") {
        let data = _format(message, terminator)

        syncQueue.async {
            do {
                try standardOutput.fileHandleForWriting.synchronize()
                try standardError.fileHandleForWriting.write(contentsOf: data)
            } catch {
            }
        }
    }

    /// Writes the provided data to standard output.
    ///
    /// - Parameter data:   The data to write to standard output.
    public func writeOutput(_ data: Data) {
        syncQueue.async {
            do {
                try standardOutput.fileHandleForWriting.write(contentsOf: data)
            } catch {
            }
        }
    }

    /// Writes the provided message and terminator strings to standard output.
    ///
    /// If ``timestampFormatter`` is not `nil`, the equivalent of the following
    /// is written to standard output:
    ///
    /// ```swift
    /// "\(timestamp) \(message)\(terminator)"
    /// ```
    ///
    /// Otherwise, the equivalent of the following is written to standard
    /// output:
    ///
    /// ```swift
    /// "\(message)\(terminator)"
    /// ```
    ///
    /// - Parameter message:    The message string to write to standard output.
    /// - Parameter terminator: The terminator string to write to standard
    ///                         output after the message string. The default is
    ///                         a newline (`"\n"`).
    public func writeOutput(_ message: String,
                            _ terminator: String = "\n") {
        let data = _format(message, terminator)

        syncQueue.async {
            do {
                try standardOutput.fileHandleForWriting.write(contentsOf: data)
            } catch {
            }
        }
    }

    // MARK: Private Type Methods

    private static func _makeFileHandle(_ fd: FileDescriptor) -> FileOrPipe {
        .file(FileHandle(fileDescriptor: fd.rawValue,
                         closeOnDealloc: true))
    }

    private static func _makeSyncQueue() -> DispatchQueue {
        let queue = DispatchQueue(label: "com.xesticode.StandardIO.syncQueue",
                                  qos: .userInteractive,
                                  target: .global(qos: .userInteractive))

        atexit_b {
            queue.sync(flags: .barrier) {}
        }

        return queue
    }

    // MARK: Private Instance Properties

    private let syncQueue: DispatchQueue

    // MARK: Private Instance Methods

    private func _format(_ message: String,
                         _ terminator: String) -> Data {
        if let formatter = timestampFormatter,
           let timestamp = formatter.string(for: Date()) {
            return Data("\(String(describing: timestamp)) \(message)\(terminator)".utf8)
        }

        return Data("\(message)\(terminator)".utf8)
    }
}

// MARK: - Sendable

extension StandardIO: Sendable {
}
