// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
import XestiTools

struct FileWrapperExtensionsTests {
}

// MARK: -

extension FileWrapperExtensionsTests {
    @Test
    func contentsOfDirectory_returnsEntries() throws {
        let child = FileWrapper(regularFileWithContents: Data("hi".utf8))
        let directory = FileWrapper(directoryWithFileWrappers: ["a.txt": child])

        let entries = try directory.contentsOfDirectory()

        #expect(entries.keys.contains("a.txt"))
    }

    @Test
    func contentsOfDirectory_throwsForRegularFile() {
        let file = FileWrapper(regularFileWithContents: Data())

        #expect(throws: (any Error).self) {
            try file.contentsOfDirectory()
        }
    }

    @Test
    func contentsOfRegularFile_returnsData() throws {
        let data = Data("hello".utf8)
        let file = FileWrapper(regularFileWithContents: data)

        #expect(try file.contentsOfRegularFile() == data)
    }

    @Test
    func contentsOfRegularFile_throwsForDirectory() {
        let directory = FileWrapper(directoryWithFileWrappers: [:])

        #expect(throws: (any Error).self) {
            try directory.contentsOfRegularFile()
        }
    }

    @Test
    func filePath_nilForInMemoryWrapper() {
        let file = FileWrapper(regularFileWithContents: Data())

        #expect(file.filePath == nil)
    }

    @Test
    func findFile_filePath() throws {
        let grandchild = FileWrapper(regularFileWithContents: Data("hi".utf8))
        let child = FileWrapper(directoryWithFileWrappers: ["b.txt": grandchild])
        let root = FileWrapper(directoryWithFileWrappers: ["a": child])

        let found = try root.findFile(FilePath("a/b.txt"))

        #expect(try found.contentsOfRegularFile() == Data("hi".utf8))
    }

    @Test
    func findFile_multipleComponents() throws {
        let grandchild = FileWrapper(regularFileWithContents: Data("hi".utf8))
        let child = FileWrapper(directoryWithFileWrappers: ["b.txt": grandchild])
        let root = FileWrapper(directoryWithFileWrappers: ["a": child])

        let found = try root.findFile(["a", "b.txt"])

        #expect(try found.contentsOfRegularFile() == Data("hi".utf8))
    }

    @Test
    func findFile_singleComponent() throws {
        let child = FileWrapper(regularFileWithContents: Data("hi".utf8))
        let root = FileWrapper(directoryWithFileWrappers: ["a.txt": child])

        let found = try root.findFile("a.txt")

        #expect(try found.contentsOfRegularFile() == Data("hi".utf8))
    }

    @Test
    func findFile_throwsWhenNotFound() {
        let root = FileWrapper(directoryWithFileWrappers: [:])

        #expect(throws: (any Error).self) {
            try root.findFile("missing.txt")
        }
    }

    @Test
    func updateRegularFile_addsNewFile() throws {
        let root = FileWrapper(directoryWithFileWrappers: [:])

        try root.updateRegularFile(named: "new.txt",
                                   using: Data("new".utf8))

        let entries = try root.contentsOfDirectory()

        #expect(try entries["new.txt"]?.contentsOfRegularFile() == Data("new".utf8))
    }

    @Test
    func updateRegularFile_throwsWhenNotDirectory() {
        let file = FileWrapper(regularFileWithContents: Data())

        #expect(throws: (any Error).self) {
            try file.updateRegularFile(named: "x",
                                       using: Data())
        }
    }

    @Test
    func updateRegularFile_updatesExistingFile() throws {
        let existing = FileWrapper(regularFileWithContents: Data("old".utf8))
        let root = FileWrapper(directoryWithFileWrappers: ["a.txt": existing])

        try root.updateRegularFile(named: "a.txt",
                                   using: Data("new".utf8))

        let entries = try root.contentsOfDirectory()

        #expect(try entries["a.txt"]?.contentsOfRegularFile() == Data("new".utf8))
    }
}
