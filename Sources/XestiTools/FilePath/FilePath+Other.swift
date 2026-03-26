// © 2023–2026 John Gary Pusey (see LICENSE.md)

public import Foundation
public import System

extension FilePath {

    // MARK: Public Type Properties

    /// The file path of the temporary directory for the current user.
    public static var temporaryDirectory: Self {
        Self(NSTemporaryDirectory())
    }

    /// The file path of a globally unique temporary directory for the process.
    ///
    /// This property generates a new file path each time its getter is invoked.
    /// The generated file path is guaranteed to be unique.
    public static var uniqueTemporaryDirectory: Self {
        temporaryDirectory.appending(ProcessInfo.processInfo.globallyUniqueString)
    }

    // MARK: Public Type Methods

    /// Matches the provided glob pattern against the file system.
    ///
    /// - Parameter pattern:    The glob pattern to match.
    ///
    /// - Returns:  An array of matching file paths. The array is empty if there
    ///             are no matches.
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
               let path = String(validatingCString: rawPath) {
                paths.append(Self(path))
            }
        }

        return paths
    }

    // MARK: Public Instance Methods

    /// Returns a new file path made by making this file path absolute.
    ///
    /// Making a file path absolute requires up to three steps:
    ///
    /// 1. Expand the initial tilde (`~`), if any, with ``expandingTilde()``.
    /// 2. If resulting file path is relative, resolve it against the current
    ///    directory.
    /// 3. Clean up the resulting file path with ``standardizing()``.
    ///
    /// - Returns:  The new file path.
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

    /// Returns the date at which the file-system node at this file path was
    /// most recently accessed.
    ///
    /// - Returns:  A `Date` value, or `nil` if the volume does not support
    ///             access dates.
    public func accessDate() -> Date? {
        _fetchResourceValue(.contentAccessDateKey)
    }

    /// Returns the date at which the file-system node at this file path was
    /// created.
    ///
    /// - Returns:  A `Date` value, or `nil` if the volume does not support
    ///             creation dates.
    public func creationDate() -> Date? {
        _fetchResourceValue(.creationDateKey)
    }

    /// Returns the kind of the file-system node at this file path.
    ///
    /// - Returns:  A `Kind` value.
    public func kind() -> Kind {
        (try? attributes().kind) ?? .unknown
    }

    /// Matches the provided glob pattern relative to this file path.
    ///
    /// - Parameter pattern:    The relative glob pattern to match.
    ///
    /// - Returns:  An array of matching file paths. The array is empty if there
    ///             are no matches.
    public func match(pattern: String) -> [Self] {
        Self.match(pattern: pushing(Self(pattern)).string)
    }

    /// Returns the date at which the file-system node at this file path was
    /// most recently modified.
    ///
    /// - Returns:  A `Date` value, or `nil` if the volume does not support
    ///             modification dates.
    public func modificationDate() -> Date? {
        _fetchResourceValue(.contentModificationDateKey)
    }

    /// Reads the contents of the regular file at this file path.
    ///
    /// - Parameter options:    Options for the read operation. Defaults to
    ///                         `[]`.
    ///
    /// - Returns:  The data read from the regular file.
    public func readData(options: Data.ReadingOptions = []) throws -> Data {
        try Data(contentsOf: fileURL,
                 options: options)
    }

    /// Recursively determines the total size in bytes of the file-system node
    /// at this file path, including any descendants.
    ///
    /// - Returns:  The total size in bytes.
    public func totalSize() throws -> UInt64 {
        let attrs = try attributes()

        if attrs.kind == .symbolicLink {
            return 0
        }

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

    /// Writes the provided data to the regular file at this file path.
    ///
    /// - Parameter data:       The data to write to the regular file.
    /// - Parameter options:    Options for the write operation. Defaults to
    ///                         `[]`.
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
