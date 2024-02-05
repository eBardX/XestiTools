// © 2024 John Gary Pusey (see LICENSE.md)

import Dispatch
import Foundation

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
