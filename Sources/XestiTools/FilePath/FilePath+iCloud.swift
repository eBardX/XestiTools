// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {

    // MARK: Public Type Methods

    public static func iCloudContainer(for containerID: String? = nil) -> Self? {
        guard let url = FileManager.default.url(forUbiquityContainerIdentifier: containerID)
        else { return nil }

        return Self(url.path)
    }

    public static func iCloudIdentity() -> ICloudIdentity? {
        guard let token = FileManager.default.ubiquityIdentityToken
        else { return nil }

        return .init(token)
    }

    // MARK: Public Instance Methods

    public func iCloudEvict() throws {
        try FileManager.default.evictUbiquitousItem(at: fileURL)
    }

    public func iCloudInfo() throws -> ICloudInfo {
        let values = try (fileURL as NSURL).resourceValues(forKeys: Self.iCloudInfoKeys)

        return .init(values)
    }

    public func iCloudMove(from local: Self) throws {
        try FileManager.default.setUbiquitous(true,
                                              itemAt: local.fileURL,
                                              destinationURL: fileURL)
    }

    public func iCloudMove(to local: Self) throws {
        try FileManager.default.setUbiquitous(false,
                                              itemAt: fileURL,
                                              destinationURL: local.fileURL)
    }

    public func iCloudSharedSnapshot() throws -> (Self, Date?) {
        var date: NSDate?

        let url = try FileManager.default.url(forPublishingUbiquitousItemAt: fileURL,
                                              expiration: &date)

        return (Self(url.path), date as? Date)
    }

    public func iCloudStartDownloading() throws {
        try FileManager.default.startDownloadingUbiquitousItem(at: fileURL)
    }

    public func iCloudTargeted() -> Bool {
        FileManager.default.isUbiquitousItem(at: fileURL)
    }

    // MARK: Private Type Properties

    private static let iCloudInfoKeys: [URLResourceKey] = [.isUbiquitousItemKey,
                                                           .ubiquitousItemContainerDisplayNameKey,
                                                           .ubiquitousItemDownloadingErrorKey,
                                                           .ubiquitousItemDownloadingStatusKey,
                                                           .ubiquitousItemDownloadRequestedKey,
                                                           .ubiquitousItemHasUnresolvedConflictsKey,
                                                           .ubiquitousItemIsDownloadingKey,
                                                           .ubiquitousItemIsExcludedFromSyncKey,
                                                           .ubiquitousItemIsSharedKey,
                                                           .ubiquitousItemIsUploadedKey,
                                                           .ubiquitousItemIsUploadingKey,
                                                           .ubiquitousItemUploadingErrorKey,
                                                           .ubiquitousSharedItemCurrentUserPermissionsKey,
                                                           .ubiquitousSharedItemCurrentUserRoleKey,
                                                           .ubiquitousSharedItemMostRecentEditorNameComponentsKey,
                                                           .ubiquitousSharedItemOwnerNameComponentsKey]
}
