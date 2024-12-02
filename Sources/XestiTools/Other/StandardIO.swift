// © 2024 John Gary Pusey (see LICENSE.md)

import Dispatch
import Foundation
import System

public struct StandardIO {

    // MARK: Public Initializers

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

    public let standardError: FileOrPipe
    public let standardInput: FileOrPipe
    public let standardOutput: FileOrPipe
    public let timestampFormatter: Formatter?

    // MARK: Public Instance Methods

    public func readInput(_ prompt: String?) -> String? {
        if let data = prompt?.data(using: .utf8) {
            syncQueue.async {
                do {
                    try standardOutput.fileHandleForWriting.synchronize()
                    try standardOutput.fileHandleForWriting.write(contentsOf: data)
                } catch {
                }
            }
        }

        return readLine()
    }

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

        return .init(standardInput: stdin,
                     standardOutput: stdout,
                     standardError: stderr)
    }

    public func writeError(_ data: Data) {
        syncQueue.async {
            do {
                try standardOutput.fileHandleForWriting.synchronize()
                try standardError.fileHandleForWriting.write(contentsOf: data)
            } catch {
            }
        }
    }

    public func writeError(_ message: String,
                           _ terminator: String = "\n") {
        guard let data = _format(message, terminator)
        else { return }

        syncQueue.async {
            do {
                try standardOutput.fileHandleForWriting.synchronize()
                try standardError.fileHandleForWriting.write(contentsOf: data)
            } catch {
            }
        }
    }

    public func writeOutput(_ data: Data) {
        syncQueue.async {
            do {
                try standardOutput.fileHandleForWriting.write(contentsOf: data)
            } catch {
            }
        }
    }

    public func writeOutput(_ message: String,
                            _ terminator: String = "\n") {
        guard let data = _format(message, terminator)
        else { return }

        syncQueue.async {
            do {
                try standardOutput.fileHandleForWriting.write(contentsOf: data)
            } catch {
            }
        }
    }

    // MARK: Private Type Methods

    private static func _makeFileHandle(_ fd: FileDescriptor) -> FileOrPipe {
        .file(.init(fileDescriptor: fd.rawValue,
                    closeOnDealloc: true))
    }

    private static func _makeSyncQueue() -> DispatchQueue {
        let queue = DispatchQueue(label: "com.xesticode.IOHandles.syncQueue",
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
                         _ terminator: String) -> Data? {
        if let formatter = timestampFormatter,
           let timestamp = formatter.string(for: Date()) {
            return "\(String(describing: timestamp)) \(message)\(terminator)".data(using: .utf8)
        }

        return "\(message)\(terminator)".data(using: .utf8)
    }
}
