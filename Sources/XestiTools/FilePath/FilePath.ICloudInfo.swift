// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {
    public struct ICloudInfo {

        // MARK: Public Initializers

        public init(_ dict: [URLResourceKey: Any]) {
            self.containerDisplayName = dict[.ubiquitousItemContainerDisplayNameKey] as? String
            self.downloadingError = dict[.ubiquitousItemDownloadingErrorKey] as? any Error
            self.downloadingStatus = dict[.ubiquitousItemDownloadingStatusKey] as? URLUbiquitousItemDownloadingStatus
            self.downloadRequested = dict[.ubiquitousItemDownloadRequestedKey] as? Bool
            self.hasUnresolvedConflicts = dict[.ubiquitousItemHasUnresolvedConflictsKey] as? Bool
            self.isDownloading = dict[.ubiquitousItemIsDownloadingKey] as? Bool
            self.isExcludedFromSync = dict[.ubiquitousItemIsExcludedFromSyncKey] as? Bool
            self.isShared = dict[.ubiquitousItemIsSharedKey] as? Bool
            self.isTargeted = dict[.isUbiquitousItemKey] as? Bool
            self.isUploaded = dict[.ubiquitousItemIsUploadedKey] as? Bool
            self.isUploading = dict[.ubiquitousItemIsUploadingKey] as? Bool
            self.sharedCurrentUserPermissions = dict[.ubiquitousSharedItemCurrentUserPermissionsKey] as? URLUbiquitousSharedItemPermissions
            self.sharedCurrentUserRole = dict[.ubiquitousSharedItemCurrentUserRoleKey] as? URLUbiquitousSharedItemRole
            self.sharedMostRecentEditorNameComponents = dict[.ubiquitousSharedItemMostRecentEditorNameComponentsKey] as? PersonNameComponents
            self.sharedOwnerNameComponents = dict[.ubiquitousSharedItemOwnerNameComponentsKey] as? PersonNameComponents
            self.uploadingError = dict[.ubiquitousItemUploadingErrorKey] as? any Error
        }

        // MARK: Public Instance Properties

        public let containerDisplayName: String?
        public let downloadingError: (any Error)?
        public let downloadingStatus: URLUbiquitousItemDownloadingStatus?
        public let downloadRequested: Bool?
        public let hasUnresolvedConflicts: Bool?
        public let isDownloading: Bool?
        public let isExcludedFromSync: Bool?
        public let isShared: Bool?
        public let isTargeted: Bool?
        public let isUploaded: Bool?
        public let isUploading: Bool?
        public let sharedCurrentUserPermissions: URLUbiquitousSharedItemPermissions?
        public let sharedCurrentUserRole: URLUbiquitousSharedItemRole?
        public let sharedMostRecentEditorNameComponents: PersonNameComponents?
        public let sharedOwnerNameComponents: PersonNameComponents?
        public let uploadingError: (any Error)?
    }
}

// MARK: - Sendable

extension FilePath.ICloudInfo: Sendable {
}
