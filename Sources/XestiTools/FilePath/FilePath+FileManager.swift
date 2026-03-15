// © 2023–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import ZIPFoundation

extension FilePath {

    // MARK: Public Type Properties

    /// The file path to the current working directory.
    public static var currentDirectory: Self {
        get { Self(FileManager.default.currentDirectoryPath) }
        set { FileManager.default.changeCurrentDirectoryPath(newValue.string) }
    }

    // MARK: Public Instance Methods

    /// Returns the attributes of the file-system node at this file path.
    ///
    /// - Returns:  An ``Attributes`` instance encapsulating the attributes.
    public func attributes() throws -> Attributes {
        try Attributes(FileManager.default.attributesOfItem(atPath: string))
    }

    /// Returns a Boolean value that indicates whether the file-system nodes in
    /// this file path and the provided file path have the same contents.
    ///
    /// - Parameter other:  The file path of a file-system node to compare
    ///                     with the contents of this file path.
    ///
    /// - Returns:  A Boolean value indicating whether the contents are equal.
    public func contentsEqual(to other: Self) -> Bool {
        FileManager.default.contentsEqual(atPath: string,
                                          andPath: other.string)
    }

    /// Performs a shallow search of the directory at this file path and returns
    /// file paths for the contained items.
    ///
    /// - Parameter keys:       An array of `URLResourceKey` instances that
    ///                         identify the file properties to pre-fetch for
    ///                         each file-system node in the directory.
    /// - Parameter options:    Options for the enumeration.
    ///
    /// - Returns:  An array of file paths, each of which identifies a
    ///             file-system node contained in the directory.
    public func contentsOfDirectory(includingPropertiesForKeys keys: [URLResourceKey]? = nil,
                                    options: FileManager.DirectoryEnumerationOptions = []) throws -> [Self] {
        try FileManager.default.contentsOfDirectory(at: fileURL,
                                                    includingPropertiesForKeys: keys,
                                                    options: options).map {
            Self($0.path)
        }
    }

    /// Copies the file-system node at this file path to the new location
    /// synchronously.
    ///
    /// - Parameter destination:    The file path at which to place the copy of
    ///                             this file-system node.
    public func copy(to destination: Self) throws {
        try FileManager.default.copyItem(at: fileURL,
                                         to: destination.fileURL)
    }

    /// Creates a directory with the provided attributes at this file path.
    ///
    /// - Parameters createIntermediates:   If `true`, this method creates any
    ///                                     nonexistent parent directories as
    ///                                     part of creating the directory. If
    ///                                     `false`, this method fails if any of
    ///                                     the intermediate parent directories
    ///                                     does not exist.
    /// - Parameters attributes             The attributes to associate with the
    ///                                     new directory.
    public func createDirectory(withIntermediateDirectories createIntermediates: Bool = true,
                                attributes: Attributes? = nil) throws {
        try FileManager.default.createDirectory(at: fileURL,
                                                withIntermediateDirectories: createIntermediates,
                                                attributes: attributes?.dictionaryRepresentation)
    }

    /// Creates a symbolic link at this file path that points to the file-system
    /// node at the provided file path.
    ///
    /// - Parameter destination:    The file path of the file-system node to be
    ///                             pointed to by the link.
    public func createSymbolicLink(to destination: Self) throws {
        try FileManager.default.createSymbolicLink(at: fileURL,
                                                   withDestinationURL: destination.fileURL)
    }

    /// Creates a new temporary replacement directory appropriate for this file
    /// path.
    ///
    /// - Returns:  The file path of the created directory.
    public func createTemporaryReplacementDirectory() throws -> Self {
        let url = try FileManager.default.url(for: .itemReplacementDirectory,
                                              in: .userDomainMask,
                                              appropriateFor: fileURL,
                                              create: true)

        return Self(url.path)
    }

    /// Returns the file path of the file-system node pointed to by the symbolic
    /// link at this file path.
    ///
    /// - Returns:  The file path of the linked file-system node.
    public func destinationOfSymbolicLink() throws -> Self {
        let dstPath = try Self(FileManager.default.destinationOfSymbolicLink(atPath: string))

        if dstPath.isAbsolute {
            return dstPath
        }

        return appending("..").pushing(dstPath)
    }

    /// Returns a Boolean value indicating whether a file-system node exists at
    /// this file path.
    ///
    /// - Returns:  `true` if the file-system node exists, or `false` if the
    ///             file does not exist or its existence could not be
    ///             determined.
    public func exists() -> Bool {
        FileManager.default.fileExists(atPath: string)
    }

    /// Returns a Boolean value indicating whether the current process appears
    /// able to delete the file-system node at this file path.
    ///
    /// - Returns:  `true` if the current process has delete privileges for
    ///             the file-system node at this file path, or `false` if the
    ///             process does not have delete privileges or the existence of
    ///             the file-system node could not be determined.
    public func isDeletable() -> Bool {
        FileManager.default.isDeletableFile(atPath: string)
    }

    /// Returns a Boolean value indicating whether the current process appears
    /// able to execute the file-system node at this file path.
    ///
    /// - Returns:  `true` if the current process has execute privileges for the
    ///             file-system node at this file path, or `false` if the
    ///             process does not have execute privileges or the existence of
    ///             the file-system node could not be determined.
    public func isExecutable() -> Bool {
        FileManager.default.isExecutableFile(atPath: string)
    }

    /// Returns a Boolean value indicating whether the current process appears
    /// able to read the file-system node at this file path.
    ///
    /// - Returns:  `true` if the current process has read privileges for the
    ///             file-system node at this file path, or `false` if the
    ///             process does not have read privileges or the existence of
    ///             the file-system node could not be determined.
    public func isReadable() -> Bool {
        FileManager.default.isReadableFile(atPath: string)
    }

    /// Returns a Boolean value indicating whether the current process appears
    /// able to write to the file-system node at this file path.
    ///
    /// - Returns:  `true` if the current process has write privileges for the
    ///             file-system node at this file path, or `false` if the
    ///             process does not have write privileges or the existence of
    ///             the file-system node could not be determined.
    public func isWritable() -> Bool {
        FileManager.default.isWritableFile(atPath: string)
    }

    /// Creates a hard link between the file-system node at this file path and
    /// the file-system node at the provided file path.
    ///
    /// - Parameters destination:   The file path identifying the location
    ///                             where the link will be created.
    public func link(to destination: Self) throws {
        try FileManager.default.linkItem(at: fileURL,
                                         to: destination.fileURL)
    }

    /// Moves the file-system node at this file path to the new location
    /// synchronously.
    ///
    /// - Parameter destination:    The file path at which to place this
    ///                             file-system node.
    public func move(to destination: Self) throws {
        try FileManager.default.moveItem(at: fileURL,
                                         to: destination.fileURL)
    }

    /// Removes the file-system node at this file path.
    public func remove() throws {
        try FileManager.default.removeItem(at: fileURL)
    }

    /// Replaces the contents of the file-system node at this file path in a
    /// manner that ensures no data loss occurs.
    ///
    /// - Parameter replacement:            The file path of the file-system
    ///                                     node containing the replacement
    ///                                     content.
    /// - Parameter backupName:             If provided, the name used to create
    ///                                     a backup of the original file-system
    ///                                     node.
    /// - Parameter usingNewMetaDataOnly:   A Boolean value indicating whether
    ///                                     only metadata from the new
    ///                                     file-system node is used. Defaults
    ///                                     to `false`.
    /// - Parameter withoutDeletingBackup:  A Boolean value indicating whether
    ///                                     the backup file-system node is
    ///                                     retained after a successful
    ///                                     replacement. Defaults to `false`.
    ///
    /// - Returns:  The file path of the replaced file-system node.
    @discardableResult
    public func replace(with replacement: Self,
                        backupName: String?,
                        usingNewMetaDataOnly: Bool = false,
                        withoutDeletingBackup: Bool = false) throws -> Self {
        var options: FileManager.ItemReplacementOptions = []

        if usingNewMetaDataOnly {
            options.formUnion(.usingNewMetadataOnly)
        }

        if withoutDeletingBackup {
            options.formUnion(.withoutDeletingBackupItem)
        }

        let resultURL = try FileManager.default.replaceItemAt(fileURL,
                                                              withItemAt: replacement.fileURL,
                                                              backupItemName: backupName,
                                                              options: options)

        return Self(resultURL.require().path)
    }

    /// Sets some or all od the attributes of the file-system node at this file
    /// path.
    ///
    /// - Parameter attributes: An ``Attributes`` instance encapsulating the
    ///                         attributes to change.
    public func setAttributes(_ attributes: Attributes) throws {
        try FileManager.default.setAttributes(attributes.dictionaryRepresentation,
                                              ofItemAtPath: string)
    }

    /// Unzips the archive file at this file path into the directory at the
    /// provided file path.
    ///
    /// - Parameter destination:    The file path of the destination directory
    ///                             of the unzip operation.
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
    public func zip(to destination: Self,
                    keepParent: Bool = true) throws {
        try FileManager.default.zipItem(at: fileURL,
                                        to: destination.fileURL,
                                        shouldKeepParent: keepParent,
                                        compressionMethod: .deflate)
    }
}
