// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
@testable import XestiTools

struct FilePathKindTests {
}

// MARK: -

extension FilePathKindTests {
    @Test
    func test_init_blockSpecial() {
        let kind = FilePath.Kind(.typeBlockSpecial)

        #expect(kind == .blockSpecial)
    }

    @Test
    func test_init_characterSpecial() {
        let kind = FilePath.Kind(.typeCharacterSpecial)

        #expect(kind == .characterSpecial)
    }

    @Test
    func test_init_directory() {
        let kind = FilePath.Kind(.typeDirectory)

        #expect(kind == .directory)
    }

    @Test
    func test_init_regular() {
        let kind = FilePath.Kind(.typeRegular)

        #expect(kind == .regular)
    }

    @Test
    func test_init_socket() {
        let kind = FilePath.Kind(.typeSocket)

        #expect(kind == .socket)
    }

    @Test
    func test_init_symbolicLink() {
        let kind = FilePath.Kind(.typeSymbolicLink)

        #expect(kind == .symbolicLink)
    }

    @Test
    func test_init_unknown() {
        let kind = FilePath.Kind(.typeUnknown)

        #expect(kind == .unknown)
    }

    @Test
    func test_type_allValues() {
        #expect(FilePath.Kind.blockSpecial.type == .typeBlockSpecial)
        #expect(FilePath.Kind.characterSpecial.type == .typeCharacterSpecial)
        #expect(FilePath.Kind.directory.type == .typeDirectory)
        #expect(FilePath.Kind.regular.type == .typeRegular)
        #expect(FilePath.Kind.socket.type == .typeSocket)
        #expect(FilePath.Kind.symbolicLink.type == .typeSymbolicLink)
        #expect(FilePath.Kind.unknown.type == .typeUnknown)
    }

    @Test
    func test_type_roundTrip() {
        let kinds: [FilePath.Kind] = [.blockSpecial,
                                      .characterSpecial,
                                      .directory,
                                      .regular,
                                      .socket,
                                      .symbolicLink,
                                      .unknown]

        for kind in kinds {
            let roundTripped = FilePath.Kind(kind.type)
            #expect(roundTripped == kind)
        }
    }
}
