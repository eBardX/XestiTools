// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct PlatformTests {
}

// MARK: -

extension PlatformTests {
    @Test
    func test_current_isMacOS() {
        #expect(Platform.current == .macOS)
    }

    @Test
    func test_init_fromRawValue() {
        #expect(Platform(rawValue: "macOS") == .macOS)
        #expect(Platform(rawValue: "Linux") == .linux)
        #expect(Platform(rawValue: "nonexistent") == nil)
    }

    @Test
    func test_rawValues() {
        #expect(Platform.android.rawValue == "Android")
        #expect(Platform.freeBSD.rawValue == "FreeBSD")
        #expect(Platform.iOS.rawValue == "iOS")
        #expect(Platform.linux.rawValue == "Linux")
        #expect(Platform.macOS.rawValue == "macOS")
        #expect(Platform.openBSD.rawValue == "OpenBSD")
        #expect(Platform.tvOS.rawValue == "tvOS")
        #expect(Platform.unknown.rawValue == "unknown")
        #expect(Platform.visionOS.rawValue == "visionOS")
        #expect(Platform.wasi.rawValue == "WASI")
        #expect(Platform.watchOS.rawValue == "watchOS")
        #expect(Platform.windows.rawValue == "Windows")
    }
}
