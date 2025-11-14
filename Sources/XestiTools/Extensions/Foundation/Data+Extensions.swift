// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation
import ZIPFoundation

extension Data {

    // MARK: Public Instance Methods

    public func unzip() throws -> FileWrapper {
        let tmpDirectoryURL = try URL.createTemporaryReplacementDirectory()

        let archive = try Archive(data: self,
                                  accessMode: .read)

        for entry in archive {
            let entryURL = tmpDirectoryURL.appendingPathComponent(entry.path)

            guard entryURL.isContained(in: tmpDirectoryURL)
            else { throw makeCocoaError(.fileReadInvalidFileName, entryURL.path) }

            guard try archive.extract(entry,
                                      to: entryURL) == entry.checksum
            else { throw Archive.ArchiveError.invalidCRC32 }
        }

        return try FileWrapper(url: tmpDirectoryURL,
                               options: .immediate)
    }
}

// MARK: - Private Functions

private func makeCocoaError(_ code: CocoaError.Code,
                            _ filePath: String? = nil) -> any Error {
    var userInfo: [String: Any] = [:]

    userInfo[NSFilePathErrorKey] = filePath

    return CocoaError(.fileReadNoSuchFile,
                      userInfo: userInfo)
}
