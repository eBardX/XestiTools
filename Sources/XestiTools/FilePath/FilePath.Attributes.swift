// © 2023–2025 John Gary Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {
    public struct Attributes {

        // MARK: Public Initializers

        public init() {
            self.kind = .unknown
        }

        public init(_ dict: [FileAttributeKey: Any]) {
            self.creationDate = dict[.creationDate] as? Date
            self.deviceID = dict[.deviceIdentifier] as? UInt32
            self.groupOwnerAccountID = dict[.groupOwnerAccountID] as? UInt32
            self.groupOwnerAccountName = dict[.groupOwnerAccountName] as? String
            self.isAppendOnly = dict[.appendOnly] as? Bool
            self.isBusy = dict[.busy] as? Bool
            self.isExtensionHidden = dict[.extensionHidden] as? Bool
            self.isImmutable = dict[.immutable] as? Bool
            self.kind = Kind((dict[.type] as? FileAttributeType) ?? .typeUnknown)
            self.modificationDate = dict[.modificationDate] as? Date
            self.ownerAccountID = dict[.ownerAccountID] as? UInt32
            self.ownerAccountName = dict[.ownerAccountName] as? String
            self.posixPermissions = dict[.posixPermissions] as? Int16
            self.referenceCount = dict[.referenceCount] as? UInt32
            self.size = dict[.size] as? UInt64
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

extension FilePath.Attributes {

    // MARK: Public Instance Properties

    public var dictionaryRepresentation: [FileAttributeKey: Any] {
        var dict: [FileAttributeKey: Any] = [.type: kind.type]

        if let creationDate {
            dict[.creationDate] = creationDate
        }

        if let deviceID {
            dict[.deviceIdentifier] = deviceID
        }

        if let groupOwnerAccountID {
            dict[.groupOwnerAccountID] = groupOwnerAccountID
        }

        if let groupOwnerAccountName {
            dict[.groupOwnerAccountName] = groupOwnerAccountName
        }

        if let isAppendOnly {
            dict[.appendOnly] = isAppendOnly
        }

        if let isBusy {
            dict[.busy] = isBusy
        }

        if let isExtensionHidden {
            dict[.extensionHidden] = isExtensionHidden
        }

        if let isImmutable {
            dict[.immutable] = isImmutable
        }

        if let modificationDate {
            dict[.modificationDate] = modificationDate
        }

        if let ownerAccountID {
            dict[.ownerAccountID] = ownerAccountID
        }

        if let ownerAccountName {
            dict[.ownerAccountName] = ownerAccountName
        }

        if let posixPermissions {
            dict[.posixPermissions] = posixPermissions
        }

        if let referenceCount {
            dict[.referenceCount] = referenceCount
        }

        if let size {
            dict[.size] = size
        }

        return dict
    }
}
