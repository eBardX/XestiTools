// © 2024 John Gary Pusey (see LICENSE.md)

import Foundation

extension StandardIO {
    public enum FileOrPipe {
        case file(FileHandle)
        case pipe(Pipe)
    }
}

// MARK: -

extension StandardIO.FileOrPipe {

    // MARK: Public Instance Properties

    public var fileHandleForReading: FileHandle {
        switch self {
        case let .file(fh):
            fh

        case let .pipe(p):
            p.fileHandleForReading
        }
    }

    public var fileHandleForWriting: FileHandle {
        switch self {
        case let .file(fh):
            fh

        case let .pipe(p):
            p.fileHandleForWriting
        }
    }

    public var value: Any {
        switch self {
        case let .file(fh):
            fh

        case let .pipe(p):
            p
        }
    }
}
