// © 2023–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {

    // MARK: Public Nested Types

    /// A container of file attribute values.
    public struct Attributes {

        // MARK: Public Initializers

        /// Creates an empty `Attributes` instance.
        public init() {
            self.kind = .unknown
        }

        /// Creates a new `Attributes` instance from the provided dictionary of
        /// file attributes.
        ///
        /// - Parameter dict:   The dictionary of file attributes to use for the
        ///                     new instance.
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

        /// A date value indicating the file’s creation date, or `nil` if no
        /// value has been set.
        public var creationDate: Date?

        /// An integer value indicating the identifier for the device on which
        /// the file resides, or `nil` if no value has been set.
        public var deviceID: UInt32?

        /// An integer value indicating the file’s group ID, or `nil` if no
        /// value has been set.
        public var groupOwnerAccountID: UInt32?

        /// A string value indicating the group name of the file’s owner, or
        /// `nil` if no value has been set.
        public var groupOwnerAccountName: String?

        /// A Boolean value indicating whether the file is append-only, or `nil`
        /// if no value has been set.
        public var isAppendOnly: Bool?

        /// A Boolean value indicating whether the file is busy, or `nil` if no
        /// value has been set.
        public var isBusy: Bool?

        /// A Boolean value indicating whether the file’s extension is hidden,
        /// or `nil` if no value has been set.
        public var isExtensionHidden: Bool?

        /// A Boolean value indicating whether the file is immutable, or `nil`
        /// if no value has been set.
        public var isImmutable: Bool?

        /// A ``Kind`` value indicating the file’s kind.
        public var kind: Kind

        /// A date value indicating the file’s last modified date, or `nil` if
        /// no value has been set.
        public var modificationDate: Date?

        /// An integer value indicating the file’s owner’s account ID, or `nil`
        /// if no value has been set.
        public var ownerAccountID: UInt32?

        /// A string value indicating the name of the file’s owner, or `nil` if
        /// no value has been set.
        public var ownerAccountName: String?

        /// An integer value indicating the file’s Posix permissions, or `nil`
        /// if no value has been set.
        public var posixPermissions: Int16?

        /// An integer value indicating the file’s reference count, or `nil` if
        /// no value has been set.
        public var referenceCount: UInt32?

        /// An integer value indicating the file’s size in bytes, or `nil` if no
        /// value has been set.
        public var size: UInt64?
    }
}

extension FilePath.Attributes {

    // MARK: Public Instance Properties

    /// A dictionary of file attributes made from all the non-`nil` values
    /// contained in this `Attributes` instance.
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

// MARK: - Sendable

extension FilePath.Attributes: Sendable {
}
