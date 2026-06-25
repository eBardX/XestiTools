// © 2023–2026 John Gary Pusey (see LICENSE.md)

private import Foundation
public import System

private import ZIPFoundation

extension FilePath {

    // MARK: Public Instance Methods

    /// Unzips the archive file at this file path into the directory at the
    /// provided file path.
    ///
    /// - Parameter destination:    The file path of the destination directory
    ///                             of the unzip operation.
    ///
    /// - Throws:   An error if the archive cannot be unzipped.
    public func unzip(to destination: Self) throws {
        try FileManager.default.unzipItem(at: fileURL,
                                          to: destination.fileURL)
    }

    /// Zips the file-system node contents at this file path into the archive
    /// file at the provided file path.
    ///
    /// - Parameter destination:    The file path of the destination archive
    ///                             file of the zip operation.
    /// - Parameter keepParent:     A Boolean value indicating whether the
    ///                             directory name of a source item should be
    ///                             used as a root element within the archive.
    ///                             Defaults to `true`.
    ///
    /// - Throws:   An error if the archive cannot be created.
    public func zip(to destination: Self,
                    keepParent: Bool = true) throws {
        try FileManager.default.zipItem(at: fileURL,
                                        to: destination.fileURL,
                                        shouldKeepParent: keepParent,
                                        compressionMethod: .deflate)
    }
}
