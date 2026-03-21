// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import ZIPFoundation

extension Data {

    // MARK: Public Instance Methods

    /// Unzips the in-memory archive contained in this `Data` instance into a
    /// temporary destination directory and returns a new file wrapper to it.
    ///
    /// - Returns:  A file wrapper locating the destination directory.
    public func unzip() throws -> FileWrapper {
        let tmpDirectoryURL = try URL.createTemporaryReplacementDirectory()

        let archive = try Archive(data: self,
                                  accessMode: .read)

        for entry in archive {
            let entryURL = tmpDirectoryURL.appendingPathComponent(entry.path)

            guard entryURL.isContained(in: tmpDirectoryURL)
            else { throw _makeCocoaError(.fileReadInvalidFileName, entryURL.path) }

            guard try archive.extract(entry,
                                      to: entryURL) == entry.checksum
            else { throw Archive.ArchiveError.invalidCRC32 }
        }

        return try FileWrapper(url: tmpDirectoryURL,
                               options: .immediate)
    }
}

// MARK: - Private Functions

private func _makeCocoaError(_ code: CocoaError.Code,
                             _ filePath: String? = nil) -> any Error {
    var userInfo: [String: Any] = [:]

    userInfo[NSFilePathErrorKey] = filePath

    return CocoaError(code,
                      userInfo: userInfo)
}
