// © 2023 J. G. Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {

    // MARK: Public Type Properties

    public static var currentDirectory: FilePath {
        get { .init(FilePath.fileManager.currentDirectoryPath) }
        set { FilePath.fileManager.changeCurrentDirectoryPath(newValue.string) }
    }

    // MARK: Public Instance Methods

    public func attributes() throws -> Attributes {
        .init(try FilePath.fileManager.attributesOfItem(atPath: string))
    }

    public func componentsToDisplay() -> [String]? {
        FilePath.fileManager.componentsToDisplay(forPath: string)
    }

    public func contentsOfDirectory(includingPropertiesForKeys keys: [URLResourceKey]? = nil,
                                    options: FileManager.DirectoryEnumerationOptions = []) throws -> [FilePath] {
        try FilePath.fileManager.contentsOfDirectory(at: fileURL,
                                                     includingPropertiesForKeys: keys,
                                                     options: options).map {
            FilePath($0.path)
        }
    }

    public func copy(to destination: FilePath) throws {
        try FilePath.fileManager.copyItem(at: fileURL,
                                          to: destination.fileURL)
    }

    public func createDirectory(withIntermediateDirectories createIntermediates: Bool = true,
                                attributes: Attributes? = nil) throws {
        try FilePath.fileManager.createDirectory(at: fileURL,
                                                 withIntermediateDirectories: createIntermediates,
                                                 attributes: attributes?.dictionaryRepresentation)
    }

    public func createFile(contents: Data? = nil,
                           attributes: Attributes? = nil) -> Bool {
        FilePath.fileManager.createFile(atPath: string,
                                        contents: contents,
                                        attributes: attributes?.dictionaryRepresentation)
    }

    public func createSymbolicLink(to destination: FilePath) throws {
        try FilePath.fileManager.createSymbolicLink(at: fileURL,
                                                    withDestinationURL: destination.fileURL)
    }

    public func destinationOfSymbolicLink() throws -> FilePath {
        let dstPath = FilePath(try FilePath.fileManager.destinationOfSymbolicLink(atPath: string))

        if dstPath.isAbsolute {
            return dstPath
        }

        return appending("..").pushing(dstPath)
    }

    public func displayName() -> String {
        FilePath.fileManager.displayName(atPath: string)
    }

    public func exists() -> Bool {
        FilePath.fileManager.fileExists(atPath: string)
    }

    public func isDeletable() -> Bool {
        FilePath.fileManager.isDeletableFile(atPath: string)
    }

    public func isExecutable() -> Bool {
        FilePath.fileManager.isExecutableFile(atPath: string)
    }

    public func isReadable() -> Bool {
        FilePath.fileManager.isReadableFile(atPath: string)
    }

    public func isWritable() -> Bool {
        FilePath.fileManager.isWritableFile(atPath: string)
    }

    public func link(to destination: FilePath) throws {
        try FilePath.fileManager.linkItem(at: fileURL,
                                          to: destination.fileURL)
    }

    public func move(to destination: FilePath) throws {
        try FilePath.fileManager.moveItem(at: fileURL,
                                          to: destination.fileURL)
    }

    public func remove() throws {
        try FilePath.fileManager.removeItem(at: fileURL)
    }

    public func replace(with replacement: FilePath,
                        backup: FilePath? = nil,
                        usingNewMetaDataOnly: Bool = false,
                        withoutDeletingBackupItem: Bool = false) throws -> FilePath {
        var options: FileManager.ItemReplacementOptions = []

        if usingNewMetaDataOnly {
            options.formUnion(.usingNewMetadataOnly)
        }

        if withoutDeletingBackupItem {
            options.formUnion(.withoutDeletingBackupItem)
        }

        var resultURL: NSURL?

        try FilePath.fileManager.replaceItem(at: fileURL,
                                             withItemAt: replacement.fileURL,
                                             backupItemName: backup?.string,
                                             options: options,
                                             resultingItemURL: &resultURL)

        return FilePath(resultURL?.path ?? "")
    }

    public func setAttributes(_ attributes: Attributes) throws {
        try FilePath.fileManager.setAttributes(attributes.dictionaryRepresentation,
                                               ofItemAtPath: string)
    }

    // MARK: Private Type Properties

    private static var fileManager: FileManager = .default
}
