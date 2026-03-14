// © 2023–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import ZIPFoundation

extension FilePath {

    // MARK: Public Type Properties

    public static var currentDirectory: Self {
        get { Self(FileManager.default.currentDirectoryPath) }
        set { FileManager.default.changeCurrentDirectoryPath(newValue.string) }
    }

    // MARK: Public Instance Methods

    public func attributes() throws -> Attributes {
        try Attributes(FileManager.default.attributesOfItem(atPath: string))
    }

    public func contentsEqual(to other: Self) -> Bool {
        FileManager.default.contentsEqual(atPath: string,
                                          andPath: other.string)
    }

    public func contentsOfDirectory(includingPropertiesForKeys keys: [URLResourceKey]? = nil,
                                    options: FileManager.DirectoryEnumerationOptions = []) throws -> [Self] {
        try FileManager.default.contentsOfDirectory(at: fileURL,
                                                    includingPropertiesForKeys: keys,
                                                    options: options).map {
            Self($0.path)
        }
    }

    public func copy(to destination: Self) throws {
        try FileManager.default.copyItem(at: fileURL,
                                         to: destination.fileURL)
    }

    public func createDirectory(withIntermediateDirectories createIntermediates: Bool = true,
                                attributes: Attributes? = nil) throws {
        try FileManager.default.createDirectory(at: fileURL,
                                                withIntermediateDirectories: createIntermediates,
                                                attributes: attributes?.dictionaryRepresentation)
    }

    public func createSymbolicLink(to destination: Self) throws {
        try FileManager.default.createSymbolicLink(at: fileURL,
                                                   withDestinationURL: destination.fileURL)
    }

    public func createTemporaryReplacementDirectory() throws -> Self {
        let url = try FileManager.default.url(for: .itemReplacementDirectory,
                                              in: .userDomainMask,
                                              appropriateFor: fileURL,
                                              create: true)

        return Self(url.path)
    }

    public func destinationOfSymbolicLink() throws -> Self {
        let dstPath = try Self(FileManager.default.destinationOfSymbolicLink(atPath: string))

        if dstPath.isAbsolute {
            return dstPath
        }

        return appending("..").pushing(dstPath)
    }

    public func exists() -> Bool {
        FileManager.default.fileExists(atPath: string)
    }

    public func isDeletable() -> Bool {
        FileManager.default.isDeletableFile(atPath: string)
    }

    public func isExecutable() -> Bool {
        FileManager.default.isExecutableFile(atPath: string)
    }

    public func isReadable() -> Bool {
        FileManager.default.isReadableFile(atPath: string)
    }

    public func isWritable() -> Bool {
        FileManager.default.isWritableFile(atPath: string)
    }

    public func link(to destination: Self) throws {
        try FileManager.default.linkItem(at: fileURL,
                                         to: destination.fileURL)
    }

    public func move(to destination: Self) throws {
        try FileManager.default.moveItem(at: fileURL,
                                         to: destination.fileURL)
    }

    public func remove() throws {
        try FileManager.default.removeItem(at: fileURL)
    }

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

    public func setAttributes(_ attributes: Attributes) throws {
        try FileManager.default.setAttributes(attributes.dictionaryRepresentation,
                                              ofItemAtPath: string)
    }

    public func unzip(to destination: Self) throws {
        try FileManager.default.unzipItem(at: fileURL,
                                          to: destination.fileURL)
    }

    public func zip(to destination: Self,
                    keepParent: Bool = true) throws {
        try FileManager.default.zipItem(at: fileURL,
                                        to: destination.fileURL,
                                        shouldKeepParent: keepParent,
                                        compressionMethod: .deflate)
    }
}
