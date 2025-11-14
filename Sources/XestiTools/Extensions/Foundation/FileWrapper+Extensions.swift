// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation
import System
import ZIPFoundation

extension FileWrapper {

    // MARK: Public Instance Properties

    public var filePath: FilePath? {
        guard let contentsURL = value(forKey: "contentsURL") as? URL
        else { return nil }

        return FilePath(contentsURL)
    }

    // MARK: Public Instance Methods

    public func contentsOfRegularFile() throws -> Data {
        guard isRegularFile
        else { throw makeCocoaError(.fileReadUnknown, preferredFilename) }

        guard let data = regularFileContents
        else { throw makeCocoaError(.fileReadNoSuchFile, preferredFilename) }

        return data
    }

    public func fetchDirectory(named name: String) throws -> FileWrapper {
        let file = try findFile([name])

        guard file.isDirectory
        else { throw makeCocoaError(.fileReadUnknown, file.preferredFilename) }

        return file
    }

    public func fetchRegularFile(named name: String) throws -> FileWrapper {
        let file = try findFile([name])

        guard file.isRegularFile
        else { throw makeCocoaError(.fileReadUnknown, file.preferredFilename) }

        return file
    }

    public func findFile(_ components: [String]) throws -> FileWrapper {
        var child = self
        var path = ""

        for component in components {
            if !path.isEmpty {
                path += "/"
            }

            path += child.preferredFilename ?? ""

            guard child.isDirectory
            else { throw makeCocoaError(.fileReadUnknown, path) }

            guard let entries = child.fileWrappers
            else { throw makeCocoaError(.fileReadNoSuchFile, path) }

            guard let file = entries[component]
            else { throw makeCocoaError(.fileReadInvalidFileName, path) }

            child = file
        }

        return child
    }

    public func findFile(_ path: FilePath) throws -> FileWrapper {
        try findFile(path.components.map { $0.string })
    }

    public func removeFile(named name: String) throws {
        let file = try findFile([name])

        removeFileWrapper(file)
    }

    public func unzip() throws -> FileWrapper {
        try (regularFileContents ?? Data()).unzip()
    }

    public func updateRegularFile(named name: String,
                                  using data: Data) throws {
        guard isDirectory
        else { throw makeCocoaError(.fileReadUnknown, preferredFilename) }

        guard let entries = fileWrappers
        else { throw makeCocoaError(.fileReadNoSuchFile, preferredFilename) }

        if let file = entries[name] {
            if file.regularFileContents != data {
                removeFileWrapper(file)
            } else {
                return
            }
        }

        addRegularFile(withContents: data,
                       preferredFilename: name)
    }

    public func zip() throws -> FileWrapper {
        let tmpDirectoryURL = try URL.createTemporaryReplacementDirectory()

        try write(to: tmpDirectoryURL,
                  options: .atomic,
                  originalContentsURL: nil)

        let tmpDirectoryPath = FilePath(tmpDirectoryURL)!   // swiftlint:disable:this force_unwrapping
        let tmpArchivePath = try tmpDirectoryPath.createTemporaryReplacementDirectory().appending("tmp.zip")

        try tmpDirectoryPath.zip(to: tmpArchivePath,
                                 keepParent: false)

        return try FileWrapper(url: tmpArchivePath.fileURL,
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
