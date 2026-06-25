// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation
public import System

extension FileWrapper {

    // MARK: Public Instance Properties

    /// The file path of the file-system node associated with this file wrapper,
    /// or `nil` if it cannot be determined.
    public var filePath: FilePath? {
        guard let contentsURL = value(forKey: "contentsURL") as? URL
        else { return nil }

        return FilePath(contentsURL)
    }

    // MARK: Public Instance Methods

    /// Returns the contents of the directory associated with this file wrapper.
    ///
    /// - Returns:  The contents of the directory.
    ///
    /// - Throws:   An error if this file wrapper is not associated with a
    ///             directory.
    public func contentsOfDirectory() throws -> [String: FileWrapper] {
        guard isDirectory
        else { throw _makeCocoaError(.fileReadUnknown, preferredFilename) }

        guard let entries = fileWrappers
        else { throw _makeCocoaError(.fileReadNoSuchFile, preferredFilename) }

        return entries
    }

    /// Returns the contents of the regular-file associated with this file
    /// wrapper.
    ///
    /// - Returns:  The contents of the regular-file.
    ///
    /// - Throws:   An error if this file wrapper is not associated with a
    ///             regular file.
    public func contentsOfRegularFile() throws -> Data {
        guard isRegularFile
        else { throw _makeCocoaError(.fileReadUnknown, preferredFilename) }

        guard let data = regularFileContents
        else { throw _makeCocoaError(.fileReadNoSuchFile, preferredFilename) }

        return data
    }

    /// Finds the child file wrapper in this directory file wrapper by matching
    /// against the provided path component.
    ///
    /// - Parameter component:  The path component identifying the file wrapper
    ///                         to find.
    ///
    /// - Returns:  The child file wrapper.
    ///
    /// - Throws:   An error if this file wrapper is not associated with a
    ///             directory, or if the child file wrapper is not found.
    public func findFile(_ component: String) throws -> FileWrapper {
        try findFile([component])
    }

    /// Finds the nested file wrapper in this directory file wrapper (or its
    /// descendants) by matching against the provided path components.
    ///
    /// - Parameter components: An array of path components identifying the file
    ///                         wrapper to find.
    ///
    /// - Returns:  The nested file wrapper.
    ///
    /// - Throws:   An error if this file wrapper is not associated with a
    ///             directory, if an intermediate path component does not refer
    ///             to a directory file wrapper, or if the nested file wrapper
    ///             is not found.
    public func findFile(_ components: [String]) throws -> FileWrapper {
        var child = self
        var path = ""

        for component in components {
            if !path.isEmpty {
                path += "/"
            }

            path += child.preferredFilename ?? ""

            guard child.isDirectory
            else { throw _makeCocoaError(.fileReadUnknown, path) }

            guard let entries = child.fileWrappers
            else { throw _makeCocoaError(.fileReadNoSuchFile, path) }

            guard let file = entries[component]
            else { throw _makeCocoaError(.fileReadInvalidFileName, path) }

            child = file
        }

        return child
    }

    /// Finds the nested file wrapper in this directory file wrapper by matching
    /// against the provided file path.
    ///
    /// - Parameter path:   The file path identifying the file wrapper to find.
    ///
    /// - Returns:  The nested file wrapper.
    ///
    /// - Throws:   An error if the file-system node is not found.
    public func findFile(_ path: FilePath) throws -> FileWrapper {
        try findFile(path.components.map { $0.string })
    }

    /// Updates the contents of the named child file wrapper in this directory
    /// file wrapper.
    ///
    /// - Parameter name:   The name of the child file wrapper to update.
    /// - Parameter data:   The new contents with which to update the found
    ///                     child file wrapper.
    ///
    /// - Throws:   An error if this file wrapper is not associated with a
    ///             directory, if no child file wrapper with the given name is
    ///             found, or if the child is not associated with a regular file.
    public func updateRegularFile(named name: String,
                                  using data: Data) throws {
        guard isDirectory
        else { throw _makeCocoaError(.fileReadUnknown, preferredFilename) }

        guard let entries = fileWrappers
        else { throw _makeCocoaError(.fileReadNoSuchFile, preferredFilename) }

        if let file = entries[name] {
            guard file.isRegularFile
            else { throw _makeCocoaError(.fileReadUnknown, file.preferredFilename) }

            if file.regularFileContents != data {
                removeFileWrapper(file)
            } else {
                return
            }
        }

        addRegularFile(withContents: data,
                       preferredFilename: name)
    }
}

// MARK: - Private Functions

private func _makeCocoaError(_ code: CocoaError.Code,
                             _ filePath: String? = nil) -> any Error {
    var userInfo: [String: Any] = [:]

    userInfo[NSFilePathErrorKey] = filePath

    return CocoaError(code,
                      userInfo: userInfo)
}
