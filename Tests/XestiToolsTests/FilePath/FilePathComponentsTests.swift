// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
@testable import XestiTools

struct FilePathComponentsTests {
}

// MARK: -

extension FilePathComponentsTests {
    @Test
    func test_appendExtensionMutating() {
        var path = FilePath("/tmp/file")

        path.appendExtension("log")

        #expect(path.string == "/tmp/file.log")
    }

    @Test
    func test_appendingExtension() {
        let path = FilePath("/tmp/file")
        let result = path.appendingExtension("txt")

        #expect(result.string == "/tmp/file.txt")
    }

    @Test
    func test_baseNameOfRoot() {
        let path = FilePath("/")

        #expect(path.baseName == "/")
    }

    @Test
    func test_baseNameSimple() {
        let path = FilePath("/usr/local/bin/tool")

        #expect(path.baseName == "tool")
    }

    @Test
    func test_baseNameWithExtension() {
        let path = FilePath("/home/user/file.txt")

        #expect(path.baseName == "file.txt")
    }

    @Test
    func test_comparable() {
        let pathA = FilePath("/a")
        let pathB = FilePath("/b")

        #expect(pathA < pathB)
        #expect(!(pathB < pathA))
    }

    @Test
    func test_fileURL() {
        let path = FilePath("/tmp/test")
        let url = path.fileURL

        #expect(url.path.contains("/tmp/test"))
    }

    @Test
    func test_removeExtensionMutating() {
        var path = FilePath("/tmp/file.log")

        path.removeExtension()

        #expect(path.string == "/tmp/file")
    }

    @Test
    func test_removingExtension() {
        let path = FilePath("/tmp/file.txt")
        let result = path.removingExtension()

        #expect(result.string == "/tmp/file")
    }

    @Test
    func test_removingExtensionNoExtension() {
        let path = FilePath("/tmp/file")
        let result = path.removingExtension()

        #expect(result.string == "/tmp/file")
    }

    @Test
    func test_replaceExtensionMutating() {
        var path = FilePath("/tmp/file.txt")

        path.replaceExtension(with: "json")

        #expect(path.string == "/tmp/file.json")
    }

    @Test
    func test_replacingExtension() {
        let path = FilePath("/tmp/file.txt")
        let result = path.replacingExtension(with: "md")

        #expect(result.string == "/tmp/file.md")
    }

    @Test
    func test_standardizeMutating() {
        var path = FilePath("/tmp/./foo/../bar")

        path.standardize()

        #expect(path.string == "/tmp/bar")
    }

    @Test
    func test_standardizing() {
        let path = FilePath("/tmp/./foo/../bar")
        let result = path.standardizing()

        #expect(result.string == "/tmp/bar")
    }
}
