// © 2025–2026 John Gary Pusey (see LICENSE.md)

import System
import Testing
@testable import XestiTools

struct FilePathCLITests {
}

// MARK: -

extension FilePathCLITests {
    @Test
    func test_initWithAbsolutePath() {
        let path = FilePath(argument: "/usr/local/bin")

        #expect(path != nil)
        #expect(path?.string == "/usr/local/bin")
    }

    @Test
    func test_initWithDotPath() {
        let path = FilePath(argument: ".")

        #expect(path != nil)
        #expect(path?.string == ".")
    }

    @Test
    func test_initWithRelativePath() {
        let path = FilePath(argument: "relative/path")

        #expect(path != nil)
        #expect(path?.string == "relative/path")
    }

    @Test
    func test_initWithTildePath() {
        let path = FilePath(argument: "~/Documents")

        #expect(path != nil)
        #expect(path?.string == "~/Documents")
    }
}
