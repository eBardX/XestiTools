// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
import XestiTools
import XestiToolsZIP

struct DataZIPTests {
    private let zipData: Data

    init() throws {
        let dir = FilePath.uniqueTemporaryDirectory

        try dir.createDirectory()

        try dir.appending("file1.txt").writeData(Data("Hello, World!".utf8))
        try dir.appending("file2.txt").writeData(Data("Test content".utf8))

        let zipPath = FilePath.uniqueTemporaryDirectory.appendingExtension("zip")

        defer { try? zipPath.remove() }

        try dir.zip(to: zipPath, keepParent: false)

        self.zipData = try zipPath.readData()
    }
}

// MARK: -

extension DataZIPTests {
    @Test
    func unzip() throws {
        let wrapper = try zipData.unzip()

        #expect(wrapper.isDirectory)
        #expect(wrapper.fileWrappers?["file1.txt"] != nil)
        #expect(wrapper.fileWrappers?["file2.txt"] != nil)
    }

    @Test
    func unzip_fileContents() throws {
        let wrapper = try zipData.unzip()
        let data1 = wrapper.fileWrappers?["file1.txt"]?.regularFileContents
        let data2 = wrapper.fileWrappers?["file2.txt"]?.regularFileContents

        #expect(data1 == Data("Hello, World!".utf8))
        #expect(data2 == Data("Test content".utf8))
    }

    @Test
    func unzip_invalidData() {
        let invalidData = Data("not a zip file".utf8)

        #expect(throws: (any Error).self) {
            try invalidData.unzip()
        }
    }
}
