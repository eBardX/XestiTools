// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
import XestiTools
import XestiToolsZIP

struct FileWrapperZIPTests {
    private let dirWrapper: FileWrapper
    private let zipWrapper: FileWrapper

    init() throws {
        let dir = FilePath.uniqueTemporaryDirectory

        try dir.createDirectory()

        try dir.appending("file1.txt").writeData(Data("Hello, World!".utf8))
        try dir.appending("file2.txt").writeData(Data("Test content".utf8))

        let zipPath = FilePath.uniqueTemporaryDirectory.appendingExtension("zip")

        defer { try? zipPath.remove() }

        try dir.zip(to: zipPath, keepParent: false)

        let zipData = try zipPath.readData()

        self.dirWrapper = try FileWrapper(url: dir.fileURL, options: .immediate)
        self.zipWrapper = FileWrapper(regularFileWithContents: zipData)
    }
}

// MARK: -

extension FileWrapperZIPTests {
    @Test
    func unzip() throws {
        let wrapper = try zipWrapper.unzip()

        #expect(wrapper.isDirectory)
        #expect(wrapper.fileWrappers?["file1.txt"] != nil)
        #expect(wrapper.fileWrappers?["file2.txt"] != nil)
    }

    @Test
    func unzip_emptyData() {
        let wrapper = FileWrapper(regularFileWithContents: Data())

        #expect(throws: (any Error).self) {
            try wrapper.unzip()
        }
    }

    @Test
    func zip() throws {
        let zipped = try dirWrapper.zip()

        #expect(zipped.isRegularFile)
        #expect((zipped.regularFileContents?.count ?? 0) > 0)
    }

    @Test
    func zip_roundTrip() throws {
        let zipped = try dirWrapper.zip()
        let unzipped = try zipped.unzip()
        let data1 = unzipped.fileWrappers?["file1.txt"]?.regularFileContents
        let data2 = unzipped.fileWrappers?["file2.txt"]?.regularFileContents

        #expect(data1 == Data("Hello, World!".utf8))
        #expect(data2 == Data("Test content".utf8))
    }
}
