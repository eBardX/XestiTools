// © 2023–2025 John Gary Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {

    // MARK: Public Type Properties

    public static var temporaryDirectory: Self {
        Self(NSTemporaryDirectory())
    }

    public static var uniqueTemporaryDirectory: Self {
        temporaryDirectory.appending(ProcessInfo.processInfo.globallyUniqueString)
    }

    // MARK: Public Type Methods

    public static func match(pattern: String) -> [Self] {
        var gt = glob_t()

        defer { globfree(&gt) }

        let flags = GLOB_BRACE | GLOB_MARK | GLOB_TILDE

        guard Darwin.glob(pattern, flags, nil, &gt) == 0,
              let endIdx = Int(exactly: gt.gl_matchc)
        else { return [] }

        var paths: [Self] = []

        for idx in 0..<endIdx {
            if let rawPath = gt.gl_pathv[idx],
               let path = String(validatingUTF8: rawPath) {
                paths.append(Self(path))
            }
        }

        return paths
    }

    // MARK: Public Instance Methods

    public func absolute() -> Self {
        if isAbsolute {
            return standardizing()
        }

        let expandedPath = expandingTilde()

        if expandedPath.isAbsolute {
            return expandedPath.standardizing()
        }

        return Self.currentDirectory.pushing(self).standardizing()
    }

    public func accessDate() -> Date? {
        _fetchResourceValue(.contentAccessDateKey)
    }

    public func creationDate() -> Date? {
        _fetchResourceValue(.creationDateKey)
    }

    public func kind() -> Kind {
        (try? attributes().kind) ?? .unknown
    }

    public func match(pattern: String) -> [Self] {
        Self.match(pattern: pushing(Self(pattern)).string)
    }

    public func modificationDate() -> Date? {
        _fetchResourceValue(.contentModificationDateKey)
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

    // Private Instance Methods

    private func _fetchResourceValue<T>(_ key: URLResourceKey) -> T? {
        var value: AnyObject?

        try? (fileURL as NSURL).getResourceValue(&value,
                                                 forKey: key)

        return value as? T
    }
}

// MARK: - Comparable

extension FilePath {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.string < rhs.string
    }
}

#if compiler(>=6)
extension FilePath: @retroactive Comparable {}
#else
extension FilePath: Comparable {}
#endif
