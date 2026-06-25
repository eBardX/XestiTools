// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation
public import System

extension FileWrapper {

    // MARK: Public Instance Methods

    /// Unzips the archive file associated with this file wrapper into a
    /// temporary directory.
    ///
    /// - Returns:  The file wrapper associated with the temporary directory.
    ///
    /// - Throws:   An error if the archive cannot be unzipped.
    public func unzip() throws -> FileWrapper {
        try (regularFileContents ?? Data()).unzip()
    }

    /// Zips the file-system node associated with this file wrapper into an
    /// archive file.
    ///
    /// - Returns:  The file wrapper associated with the archive file.
    ///
    /// - Throws:   An error if the archive cannot be created.
    public func zip() throws -> FileWrapper {
        let tmpDirectoryURL = try URL.createTemporaryReplacementDirectory()

        try write(to: tmpDirectoryURL,
                  options: .atomic,
                  originalContentsURL: nil)

        let tmpDirectoryPath = FilePath(tmpDirectoryURL)!   // swiftlint:disable:this force_unwrapping
        let tmpArchivePath = try tmpDirectoryPath.createTemporaryReplacementDirectory().appending("tmp.zip")

        try tmpDirectoryPath.zip(to: tmpArchivePath,
                                 keepParent: false)

        return try FileWrapper(url: tmpArchivePath.fileURL,
                               options: .immediate)
    }
}
