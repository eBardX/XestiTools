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
    func test_initFromBlockSpecial() {
        let kind = FilePath.Kind(.typeBlockSpecial)

        #expect(kind == .blockSpecial)
    }

    @Test
    func test_initFromCharacterSpecial() {
        let kind = FilePath.Kind(.typeCharacterSpecial)

        #expect(kind == .characterSpecial)
    }

    @Test
    func test_initFromDirectory() {
        let kind = FilePath.Kind(.typeDirectory)

        #expect(kind == .directory)
    }

    @Test
    func test_initFromRegular() {
        let kind = FilePath.Kind(.typeRegular)

        #expect(kind == .regular)
    }

    @Test
    func test_initFromSocket() {
        let kind = FilePath.Kind(.typeSocket)

        #expect(kind == .socket)
    }

    @Test
    func test_initFromSymbolicLink() {
        let kind = FilePath.Kind(.typeSymbolicLink)

        #expect(kind == .symbolicLink)
    }

    @Test
    func test_initFromUnknown() {
        let kind = FilePath.Kind(.typeUnknown)

        #expect(kind == .unknown)
    }

    @Test
    func test_typePropertyValues() {
        #expect(FilePath.Kind.blockSpecial.type == .typeBlockSpecial)
        #expect(FilePath.Kind.characterSpecial.type == .typeCharacterSpecial)
        #expect(FilePath.Kind.directory.type == .typeDirectory)
        #expect(FilePath.Kind.regular.type == .typeRegular)
        #expect(FilePath.Kind.socket.type == .typeSocket)
        #expect(FilePath.Kind.symbolicLink.type == .typeSymbolicLink)
        #expect(FilePath.Kind.unknown.type == .typeUnknown)
    }

    @Test
    func test_typeRoundTrip() {
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
