// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
import XestiTools
import XestiToolsZIP

struct FilePathZIPTests {
    private let sourceDir: FilePath

    init() throws {
        let dir = FilePath.uniqueTemporaryDirectory

        try dir.createDirectory()

        try dir.appending("file1.txt").writeData(Data("Hello, World!".utf8))
        try dir.appending("file2.txt").writeData(Data("Test content".utf8))

        self.sourceDir = dir
    }
}

// MARK: -

extension FilePathZIPTests {
    @Test
    func unzip_invalidFile() throws {
        let fakePath = FilePath.uniqueTemporaryDirectory.appendingExtension("zip")
        let destDir = FilePath.uniqueTemporaryDirectory
        defer { try? fakePath.remove() }
        defer { try? destDir.remove() }

        try fakePath.writeData(Data("not a zip".utf8))

        #expect(throws: (any Error).self) {
            try fakePath.unzip(to: destDir)
        }
    }

    @Test
    func zip() throws {
        let zipPath = FilePath.uniqueTemporaryDirectory.appendingExtension("zip")
        defer { try? zipPath.remove() }

        try sourceDir.zip(to: zipPath)

        #expect(zipPath.exists())
        #expect((try? zipPath.attributes().kind) == .regular)
    }

    @Test
    func zip_keepParent_false() throws {
        let zipPath = FilePath.uniqueTemporaryDirectory.appendingExtension("zip")
        let destDir = FilePath.uniqueTemporaryDirectory
        defer { try? zipPath.remove() }
        defer { try? destDir.remove() }

        try sourceDir.zip(to: zipPath, keepParent: false)
        try zipPath.unzip(to: destDir)

        #expect(destDir.appending("file1.txt").exists())
        #expect(destDir.appending("file2.txt").exists())
    }

    @Test
    func zip_keepParent_true() throws {
        let zipPath = FilePath.uniqueTemporaryDirectory.appendingExtension("zip")
        let destDir = FilePath.uniqueTemporaryDirectory
        defer { try? zipPath.remove() }
        defer { try? destDir.remove() }

        try sourceDir.zip(to: zipPath, keepParent: true)
        try zipPath.unzip(to: destDir)

        let innerDir = FilePath(destDir.string + "/" + sourceDir.baseName)

        #expect(innerDir.exists())
        #expect(innerDir.appending("file1.txt").exists())
        #expect(innerDir.appending("file2.txt").exists())
    }

    @Test
    func zip_unzip_roundTrip() throws {
        let zipPath = FilePath.uniqueTemporaryDirectory.appendingExtension("zip")
        let destDir = FilePath.uniqueTemporaryDirectory
        defer { try? zipPath.remove() }
        defer { try? destDir.remove() }

        try sourceDir.zip(to: zipPath, keepParent: false)
        try zipPath.unzip(to: destDir)

        let file1Data = try destDir.appending("file1.txt").readData()
        let file2Data = try destDir.appending("file2.txt").readData()

        #expect(file1Data == Data("Hello, World!".utf8))
        #expect(file2Data == Data("Test content".utf8))
    }
}
