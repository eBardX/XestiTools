// © 2023 J. G. Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {

    // MARK: Public Type Properties

    public static var temporaryDirectory: FilePath {
        FilePath(NSTemporaryDirectory())
    }

    public static var uniqueTemporaryDirectory: FilePath {
        temporaryDirectory.appending(ProcessInfo.processInfo.globallyUniqueString)
    }

    // MARK: Public Type Methods

    public static func match(pattern: String) -> [FilePath] {
        var gt = glob_t()

        defer { globfree(&gt) }

        let flags = GLOB_BRACE | GLOB_MARK | GLOB_TILDE

        guard Darwin.glob(pattern, flags, nil, &gt) == 0
        else { return [] }

        return (0..<Int(gt.gl_matchc)).compactMap {
            guard let rawPath = gt.gl_pathv[$0],
                  let path = String(validatingUTF8: rawPath)
            else { return nil }

            return FilePath(path)
        }
    }

    // MARK: Public Instance Methods

    public func absolute() -> FilePath {
        if isAbsolute {
            return standardizing()
        }

        let expandedPath = expandingTilde()

        if expandedPath.isAbsolute {
            return expandedPath.standardizing()
        }

        return FilePath.currentDirectory.pushing(self).standardizing()
    }

    public func kind() -> Kind {
        (try? attributes().kind) ?? .unknown
    }

    public func match(pattern: String) -> [FilePath] {
        FilePath.match(pattern: pushing(FilePath(pattern)).string)
    }

    public func readData(options: Data.ReadingOptions = []) throws -> Data {
        try Data(contentsOf: fileURL,
                 options: options)
    }

    public func totalSize() throws -> UInt64 {
        let attrs = try attributes()

        if attrs.kind != .directory {
            return attrs.size ?? 0
        }

        var size: UInt64 = 0

        let children = try contentsOfDirectory()

        for child in children {
            size += try child.totalSize()
        }

        return size
    }

    public func writeData(_ data: Data,
                          options: Data.WritingOptions = []) throws {
        try data.write(to: fileURL,
                       options: options)
    }
}

// MARK: - Comparable

extension FilePath: Comparable {
    public static func < (lhs: FilePath,
                          rhs: FilePath) -> Bool {
        lhs.string < rhs.string
    }
}
