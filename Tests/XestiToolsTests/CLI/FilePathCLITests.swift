// © 2025–2026 John Gary Pusey (see LICENSE.md)

import System
import Testing
@testable import XestiTools

struct FilePathCLITests {
}

// MARK: -

extension FilePathCLITests {
    @Test
    func init_absolutePath() {
        let path = FilePath(argument: "/usr/local/bin")

        #expect(path != nil)
        #expect(path?.string == "/usr/local/bin")
    }

    @Test
    func init_dotPath() {
        let path = FilePath(argument: ".")

        #expect(path != nil)
        #expect(path?.string == ".")
    }

    @Test
    func init_relativePath() {
        let path = FilePath(argument: "relative/path")

        #expect(path != nil)
        #expect(path?.string == "relative/path")
    }

    @Test
    func init_tildePath() {
        let path = FilePath(argument: "~/Documents")

        #expect(path != nil)
        #expect(path?.string == "~/Documents")
    }
}
