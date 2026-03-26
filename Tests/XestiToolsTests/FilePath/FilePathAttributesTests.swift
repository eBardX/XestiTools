// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import Testing
@testable import XestiTools

struct FilePathAttributesTests {
}

// MARK: -

extension FilePathAttributesTests {
    @Test
    func test_dictionaryRepresentationWithDefaults() {
        let attrs = FilePath.Attributes()
        let dict = attrs.dictionaryRepresentation

        #expect(dict[.type] as? FileAttributeType == .typeUnknown)
        #expect(dict.count == 1)
    }

    @Test
    func test_dictionaryRepresentationWithValues() {
        var attrs = FilePath.Attributes()

        attrs.kind = .regular
        attrs.size = 2_048
        attrs.ownerAccountName = "user"
        attrs.isAppendOnly = true

        let dict = attrs.dictionaryRepresentation

        #expect(dict[.type] as? FileAttributeType == .typeRegular)
        #expect(dict[.size] as? UInt64 == 2_048)
        #expect(dict[.ownerAccountName] as? String == "user")
        #expect(dict[.appendOnly] as? Bool == true)
    }

    @Test
    func test_dictionaryRoundTrip() {
        let now = Date()

        var original = FilePath.Attributes()

        original.kind = .directory
        original.creationDate = now
        original.size = 4_096
        original.ownerAccountName = "admin"
        original.groupOwnerAccountName = "staff"

        let dict = original.dictionaryRepresentation
        let restored = FilePath.Attributes(dict)

        #expect(restored.kind == .directory)
        #expect(restored.creationDate == now)
        #expect(restored.size == 4_096)
        #expect(restored.ownerAccountName == "admin")
        #expect(restored.groupOwnerAccountName == "staff")
    }

    @Test
    func test_emptyInit() {
        let attrs = FilePath.Attributes()

        #expect(attrs.kind == .unknown)
        #expect(attrs.creationDate == nil)
        #expect(attrs.deviceID == nil)
        #expect(attrs.groupOwnerAccountID == nil)
        #expect(attrs.groupOwnerAccountName == nil)
        #expect(attrs.isAppendOnly == nil)
        #expect(attrs.isBusy == nil)
        #expect(attrs.isExtensionHidden == nil)
        #expect(attrs.isImmutable == nil)
        #expect(attrs.modificationDate == nil)
        #expect(attrs.ownerAccountID == nil)
        #expect(attrs.ownerAccountName == nil)
        #expect(attrs.posixPermissions == nil)
        #expect(attrs.referenceCount == nil)
        #expect(attrs.size == nil)
    }

    @Test
    func test_initFromDictionary() {
        let now = Date()
        let dict: [FileAttributeKey: Any] = [.type: FileAttributeType.typeRegular,
                                             .creationDate: now,
                                             .size: UInt64(1_024),
                                             .ownerAccountName: "testuser",
                                             .posixPermissions: Int16(0o644)]
        let attrs = FilePath.Attributes(dict)

        #expect(attrs.kind == .regular)
        #expect(attrs.creationDate == now)
        #expect(attrs.size == 1_024)
        #expect(attrs.ownerAccountName == "testuser")
        #expect(attrs.posixPermissions == 0o644)
    }

    @Test
    func test_initFromEmptyDictionary() {
        let dict: [FileAttributeKey: Any] = [:]
        let attrs = FilePath.Attributes(dict)

        #expect(attrs.kind == .unknown)
    }

    @Test
    func test_mutableProperties() {
        var attrs = FilePath.Attributes()

        attrs.isBusy = true
        attrs.isExtensionHidden = false
        attrs.isImmutable = true
        attrs.deviceID = 42
        attrs.referenceCount = 3
        attrs.groupOwnerAccountID = 20
        attrs.ownerAccountID = 501

        #expect(attrs.isBusy == true)
        #expect(attrs.isExtensionHidden == false)
        #expect(attrs.isImmutable == true)
        #expect(attrs.deviceID == 42)
        #expect(attrs.referenceCount == 3)
        #expect(attrs.groupOwnerAccountID == 20)
        #expect(attrs.ownerAccountID == 501)
    }
}
