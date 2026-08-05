// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
import XestiTools

struct FilePathFileManagerTests {
}

// MARK: -

extension FilePathFileManagerTests {
    @Test
    func attributes_reflectsFileKind() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")

        try file.writeData(Data("hi".utf8))

        #expect(try file.attributes().kind == .regular)
    }

    @Test
    func contentsEqual_differentContents() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file1 = dir.appending("a.txt")
        let file2 = dir.appending("b.txt")

        try file1.writeData(Data("one".utf8))
        try file2.writeData(Data("two".utf8))

        #expect(!file1.contentsEqual(to: file2))
    }

    @Test
    func contentsEqual_sameContents() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file1 = dir.appending("a.txt")
        let file2 = dir.appending("b.txt")

        try file1.writeData(Data("same".utf8))
        try file2.writeData(Data("same".utf8))

        #expect(file1.contentsEqual(to: file2))
    }

    @Test
    func contentsOfDirectory_listsEntries() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        try dir.appending("a.txt").writeData(Data())
        try dir.appending("b.txt").writeData(Data())

        let contents = try dir.contentsOfDirectory()

        #expect(Set(contents.map { $0.baseName }) == ["a.txt", "b.txt"])
    }

    @Test
    func copy_duplicatesContents() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let source = dir.appending("a.txt")
        let destination = dir.appending("b.txt")

        try source.writeData(Data("hi".utf8))
        try source.copy(to: destination)

        #expect(try destination.readData() == Data("hi".utf8))
    }

    @Test
    func createDirectory_makesDirectory() throws {
        let dir = FilePath.uniqueTemporaryDirectory

        try dir.createDirectory()

        defer { try? dir.remove() }

        #expect(dir.exists())
        #expect(try dir.attributes().kind == .directory)
    }

    @Test
    func createSymbolicLink_pointsToDestination() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let target = dir.appending("target.txt")
        let link = dir.appending("link.txt")

        try target.writeData(Data("hi".utf8))
        try link.createSymbolicLink(to: target)

        #expect(try link.attributes().kind == .symbolicLink)
    }

    @Test
    func createTemporaryReplacementDirectory_createsDirectory() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let replacement = try dir.createTemporaryReplacementDirectory()

        defer { try? replacement.remove() }

        #expect(replacement.exists())
    }

    @Test
    func currentDirectory_getSet() throws {
        let original = FilePath.currentDirectory
        let dir = try makeTemporaryDirectory()

        defer {
            FilePath.currentDirectory = original
            try? dir.remove()
        }

        FilePath.currentDirectory = dir

        #expect(FilePath.currentDirectory.resolvingSymbolicLinks().string == dir.resolvingSymbolicLinks().string)
    }

    @Test
    func destinationOfSymbolicLink_resolvesTarget() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let target = dir.appending("target.txt")
        let link = dir.appending("link.txt")

        try target.writeData(Data("hi".utf8))
        try link.createSymbolicLink(to: target)

        #expect(try link.destinationOfSymbolicLink() == target)
    }

    @Test
    func exists_false() {
        let missing = FilePath.uniqueTemporaryDirectory

        #expect(!missing.exists())
    }

    @Test
    func exists_true() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        #expect(dir.exists())
    }

    @Test
    func isDeletable_true() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")

        try file.writeData(Data())

        #expect(file.isDeletable())
    }

    @Test
    func isExecutable_true() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        #expect(dir.isExecutable())
    }

    @Test
    func isReadable_true() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        #expect(dir.isReadable())
    }

    @Test
    func isWritable_true() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        #expect(dir.isWritable())
    }

    @Test
    func link_createsHardLink() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let source = dir.appending("a.txt")
        let destination = dir.appending("b.txt")

        try source.writeData(Data("hi".utf8))
        try source.link(to: destination)

        #expect(try destination.readData() == Data("hi".utf8))
    }

    @Test
    func move_relocatesFile() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let source = dir.appending("a.txt")
        let destination = dir.appending("b.txt")

        try source.writeData(Data("hi".utf8))
        try source.move(to: destination)

        #expect(!source.exists())
        #expect(try destination.readData() == Data("hi".utf8))
    }

    @Test
    func remove_deletesFile() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")

        try file.writeData(Data())
        try file.remove()

        #expect(!file.exists())
    }

    @Test
    func replace_swapsContents() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let original = dir.appending("original.txt")
        let replacement = dir.appending("replacement.txt")

        try original.writeData(Data("old".utf8))
        try replacement.writeData(Data("new".utf8))

        let result = try original.replace(with: replacement,
                                          backupName: nil)

        #expect(try result.readData() == Data("new".utf8))
    }

    @Test
    func setAttributes_appliesChanges() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")

        try file.writeData(Data())

        var attrs = FilePath.Attributes()

        attrs.posixPermissions = 0o600

        try file.setAttributes(attrs)

        #expect(try file.attributes().posixPermissions == 0o600)
    }
}
