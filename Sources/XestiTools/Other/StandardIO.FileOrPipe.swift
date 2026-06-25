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

    /// The file handle for reading: the held `FileHandle`, or the read end
    /// of the held `Pipe`.
    public var fileHandleForReading: FileHandle {
        switch self {
        case let .file(fh):
            fh

        case let .pipe(p):
            p.fileHandleForReading
        }
    }

    /// The file handle for writing: the held `FileHandle`, or the write end
    /// of the held `Pipe`.
    public var fileHandleForWriting: FileHandle {
        switch self {
        case let .file(fh):
            fh

        case let .pipe(p):
            p.fileHandleForWriting
        }
    }

    /// The held `FileHandle` or `Pipe` instance as an `Any` value.
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
