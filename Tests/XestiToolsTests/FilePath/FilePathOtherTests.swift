// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
import XestiTools

struct FilePathOtherTests {
}

// MARK: -

extension FilePathOtherTests {
    @Test
    func absolute_expandsRelativePath() throws {
        let original = FilePath.currentDirectory
        let dir = try makeTemporaryDirectory()

        defer {
            FilePath.currentDirectory = original
            try? dir.remove()
        }

        let expected = dir.appending("a.txt")

        try expected.writeData(Data())

        FilePath.currentDirectory = dir

        let relative = FilePath("a.txt")

        #expect(relative.absolute().resolvingSymbolicLinks().string ==
                expected.resolvingSymbolicLinks().string)
    }

    @Test
    func accessDate_returnsDate() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")

        try file.writeData(Data())

        #expect(file.accessDate() != nil)
    }

    @Test
    func comparable() {
        let a = FilePath("/a")
        let b = FilePath("/b")

        #expect(a < b)
        #expect(!(b < a))
    }

    @Test
    func creationDate_returnsDate() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")

        try file.writeData(Data())

        #expect(file.creationDate() != nil)
    }

    @Test
    func kind_directory() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        #expect(dir.kind() == .directory)
    }

    @Test
    func kind_unknownForMissingPath() {
        let missing = FilePath.uniqueTemporaryDirectory

        #expect(missing.kind() == .unknown)
    }

    @Test
    func match_instanceRelativeToPath() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        try dir.appending("a.txt").writeData(Data())
        try dir.appending("b.log").writeData(Data())

        let matches = dir.match(pattern: "*.txt")

        #expect(matches.map { $0.baseName } == ["a.txt"])
    }

    @Test
    func match_staticPattern() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        try dir.appending("a.txt").writeData(Data())

        let matches = FilePath.match(pattern: dir.appending("*.txt").string)

        #expect(matches.map { $0.baseName } == ["a.txt"])
    }

    @Test
    func modificationDate_returnsDate() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")

        try file.writeData(Data())

        #expect(file.modificationDate() != nil)
    }

    @Test
    func readData_roundTrip() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")
        let data = Data("hello".utf8)

        try file.writeData(data)

        #expect(try file.readData() == data)
    }

    @Test
    func temporaryDirectory_matchesSystemTemp() {
        #expect(FilePath.temporaryDirectory == FilePath(NSTemporaryDirectory()))
    }

    @Test
    func totalSize_directory() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        try dir.appending("a.txt").writeData(Data(repeating: 0, count: 3))
        try dir.appending("b.txt").writeData(Data(repeating: 0, count: 5))

        #expect(try dir.totalSize() == 8)
    }

    @Test
    func totalSize_regularFile() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")

        try file.writeData(Data(repeating: 0, count: 7))

        #expect(try file.totalSize() == 7)
    }

    @Test
    func uniqueTemporaryDirectory_isUnique() {
        let a = FilePath.uniqueTemporaryDirectory
        let b = FilePath.uniqueTemporaryDirectory

        #expect(a.string != b.string)
    }

    @Test
    func writeData_createsFile() throws {
        let dir = try makeTemporaryDirectory()

        defer { try? dir.remove() }

        let file = dir.appending("a.txt")

        try file.writeData(Data("hi".utf8))

        #expect(file.exists())
    }
}
