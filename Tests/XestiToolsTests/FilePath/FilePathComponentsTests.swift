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
    func appendExtension_mutating() {
        var path = FilePath("/tmp/file")

        path.appendExtension("log")

        #expect(path.string == "/tmp/file.log")
    }

    @Test
    func appendingExtension() {
        let path = FilePath("/tmp/file")
        let result = path.appendingExtension("txt")

        #expect(result.string == "/tmp/file.txt")
    }

    @Test
    func baseName_root() {
        let path = FilePath("/")

        #expect(path.baseName == "/")
    }

    @Test
    func baseName_simple() {
        let path = FilePath("/usr/local/bin/tool")

        #expect(path.baseName == "tool")
    }

    @Test
    func baseName_withExtension() {
        let path = FilePath("/home/user/file.txt")

        #expect(path.baseName == "file.txt")
    }

    @Test
    func comparable() {
        let pathA = FilePath("/a")
        let pathB = FilePath("/b")

        #expect(pathA < pathB)
        #expect(!(pathB < pathA))
    }

    @Test
    func fileURL() {
        let path = FilePath("/tmp/test")
        let url = path.fileURL

        #expect(url.path.contains("/tmp/test"))
    }

    @Test
    func removeExtension_mutating() {
        var path = FilePath("/tmp/file.log")

        path.removeExtension()

        #expect(path.string == "/tmp/file")
    }

    @Test
    func removingExtension() {
        let path = FilePath("/tmp/file.txt")
        let result = path.removingExtension()

        #expect(result.string == "/tmp/file")
    }

    @Test
    func removingExtension_noExtension() {
        let path = FilePath("/tmp/file")
        let result = path.removingExtension()

        #expect(result.string == "/tmp/file")
    }

    @Test
    func replaceExtension_mutating() {
        var path = FilePath("/tmp/file.txt")

        path.replaceExtension(with: "json")

        #expect(path.string == "/tmp/file.json")
    }

    @Test
    func replacingExtension() {
        let path = FilePath("/tmp/file.txt")
        let result = path.replacingExtension(with: "md")

        #expect(result.string == "/tmp/file.md")
    }

    @Test
    func standardize_mutating() {
        var path = FilePath("/tmp/./foo/../bar")

        path.standardize()

        #expect(path.string == "/tmp/bar")
    }

    @Test
    func standardizing() {
        let path = FilePath("/tmp/./foo/../bar")
        let result = path.standardizing()

        #expect(result.string == "/tmp/bar")
    }
}
