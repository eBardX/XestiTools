// © 2023 J. G. Pusey (see LICENSE.md)

import Foundation
import System

public extension FilePath {
    struct Attributes {

        // MARK: Public Initializers

        public init() {
            self.kind = .unknown
        }

        public init(_ attrs: [FileAttributeKey: Any]) {
            self.creationDate = attrs[.creationDate] as? Date
            self.deviceID = attrs[.deviceIdentifier] as? UInt32
            self.groupOwnerAccountID = attrs[.groupOwnerAccountID] as? UInt32
            self.groupOwnerAccountName = attrs[.groupOwnerAccountName] as? String
            self.isAppendOnly = attrs[.appendOnly] as? Bool
            self.isBusy = attrs[.busy] as? Bool
            self.isExtensionHidden = attrs[.extensionHidden] as? Bool
            self.isImmutable = attrs[.immutable] as? Bool
            self.kind = Kind((attrs[.type] as? FileAttributeType) ?? .typeUnknown)
            self.modificationDate = attrs[.modificationDate] as? Date
            self.ownerAccountID = attrs[.ownerAccountID] as? UInt32
            self.ownerAccountName = attrs[.ownerAccountName] as? String
            self.posixPermissions = attrs[.posixPermissions] as? Int16
            self.referenceCount = attrs[.referenceCount] as? UInt32
            self.size = attrs[.size] as? UInt64
        }

        // MARK: Public Instance Properties

        public var creationDate: Date?
        public var deviceID: UInt32?
        public var groupOwnerAccountID: UInt32?
        public var groupOwnerAccountName: String?
        public var isAppendOnly: Bool?
        public var isBusy: Bool?
        public var isExtensionHidden: Bool?
        public var isImmutable: Bool?
        public var kind: Kind
        public var modificationDate: Date?
        public var ownerAccountID: UInt32?
        public var ownerAccountName: String?
        public var posixPermissions: Int16?
        public var referenceCount: UInt32?
        public var size: UInt64?
    }
}

public extension FilePath.Attributes {

    // MARK: Public Instance Properties

    var dictionaryRepresentation: [FileAttributeKey: Any] {
        var dict: [FileAttributeKey: Any] = [.type: kind.type]

        if let value = creationDate {
            dict[.creationDate] = value
        }

        if let value = deviceID {
            dict[.deviceIdentifier] = value
        }

        if let value = groupOwnerAccountID {
            dict[.groupOwnerAccountID] = value
        }

        if let value = groupOwnerAccountName {
            dict[.groupOwnerAccountName] = value
        }

        if let value = isAppendOnly {
            dict[.appendOnly] = value
        }

        if let value = isBusy {
            dict[.busy] = value
        }

        if let value = isExtensionHidden {
            dict[.extensionHidden] = value
        }

        if let value = isImmutable {
            dict[.immutable] = value
        }

        if let value = modificationDate {
            dict[.modificationDate] = value
        }

        if let value = ownerAccountID {
            dict[.ownerAccountID] = value
        }

        if let value = ownerAccountName {
            dict[.ownerAccountName] = value
        }

        if let value = posixPermissions {
            dict[.posixPermissions] = value
        }

        if let value = referenceCount {
            dict[.referenceCount] = value
        }

        if let value = size {
            dict[.size] = value
        }

        return dict
    }
}
