// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiToolsCLI

struct URLCLITests {
}

// MARK: -

extension URLCLITests {
    @Test
    func init_fileURL() {
        let url = URL(argument: "file:///tmp/test.txt")

        #expect(url != nil)
        #expect(url?.scheme == "file")
    }

    @Test
    func init_invalidArgument() {
        let url = URL(argument: "")

        #expect(url == nil)
    }

    @Test
    func init_validHTTPArgument() {
        let url = URL(argument: "https://example.com")

        #expect(url != nil)
        #expect(url?.scheme == "https")
        #expect(url?.host == "example.com")
    }

    @Test
    func init_validHTTPArgumentWithPath() {
        let url = URL(argument: "https://example.com/path/to/resource")

        #expect(url != nil)
        #expect(url?.path.contains("/path/to/resource") == true)
    }
}
