// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct URLExtensionsTests {
}

// MARK: -

extension URLExtensionsTests {
    @Test
    func createTemporaryReplacementDirectory() throws {
        let url = try URL.createTemporaryReplacementDirectory()

        defer { try? FileManager.default.removeItem(at: url) }

        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: url.path(percentEncoded: false),
                                                    isDirectory: &isDirectory)

        #expect(exists)
        #expect(isDirectory.boolValue)
    }
}
