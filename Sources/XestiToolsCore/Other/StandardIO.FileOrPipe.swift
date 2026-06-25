// © 2024–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension StandardIO {

    // MARK: Public Nested Types

    /// A value that holds either a `FileHandle` instance or a `Pipe` instance.
    public enum FileOrPipe {
        /// A `FileHandle` instance.
        case file(FileHandle)

        /// A `Pipe` instance.
        case pipe(Pipe)
    }
}

// MARK: -

extension StandardIO.FileOrPipe {

    // MARK: Public Instance Properties

    /// If this value holds a `Pipe` instance, returns the pipe’s read file
    /// handle; otherwise, returns the `FileHandle` instance.
    public var fileHandleForReading: FileHandle {
        switch self {
        case let .file(fh):
            fh

        case let .pipe(p):
            p.fileHandleForReading
        }
    }

    /// If this value holds a `Pipe` instance, returns the pipe’s write file
    /// handle; otherwise, returns the `FileHandle` instance.
    public var fileHandleForWriting: FileHandle {
        switch self {
        case let .file(fh):
            fh

        case let .pipe(p):
            p.fileHandleForWriting
        }
    }

    /// Returns the held `FileHandle` or `Pipe` instance as an `Any` type.
    public var value: Any {
        switch self {
        case let .file(fh):
            fh

        case let .pipe(p):
            p
        }
    }
}

// MARK: - Sendable

extension StandardIO.FileOrPipe: Sendable {
}
