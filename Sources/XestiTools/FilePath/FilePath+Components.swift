// © 2024–2026 John Gary Pusey (see LICENSE.md)

public import Foundation
public import System

extension FilePath {

    // MARK: Public Instance Properties

    /// The base name of this file path.
    public var baseName: String {
        (string as NSString).lastPathComponent
    }

    /// The file URL equivalent to the file path.
    public var fileURL: URL {
        if #available(macOS 13.0, iOS 16.0, *) {
            URL(filePath: self).require()
        } else {
            URL(self).require()
        }
    }

    // MARK: Public Instance Methods

    /// Replaces the current home directory portion of this file path with a
    /// tilde (~) character.
    public mutating func abbreviateWithTilde() {
        self = abbreviatingWithTilde()
    }

    /// Returns a new file path made by replacing the current home directory
    /// portion of this file path with a tilde (~) character.
    ///
    /// - Returns:  The new file path.
    public func abbreviatingWithTilde() -> Self {
        Self((string as NSString).abbreviatingWithTildeInPath)
    }

    /// Appends an extension separator, followed by the provided extension, to
    /// this file path.
    ///
    /// - Parameter ext:    The extension to append.
    public mutating func appendExtension(_ ext: String) {
        self = appendingExtension(ext)
    }

    /// Returns a new file path made by appending an extension separator,
    /// followed by the provided extension, to this file path.
    ///
    /// - Parameter ext:    The extension to append.
    ///
    /// - Returns:  The new file path.
    public func appendingExtension(_ ext: String) -> Self {
        guard let result = (string as NSString).appendingPathExtension(ext)
        else { return self }

        return Self(result)
    }

    /// Returns a new file path made by expanding the initial component of this
    /// file path to its full path value.
    ///
    /// - Returns:  The new file path.
    public func expandingTilde() -> Self {
        Self((string as NSString).expandingTildeInPath)
    }

    /// Expands the initial component of this file path to its full path value.
    public mutating func expandTilde() {
        self = expandingTilde()
    }

    /// Removes the extension from this file path.
    public mutating func removeExtension() {
        self = removingExtension()
    }

    /// Returns a new file path made by removing the extension from this file
    /// path.
    ///
    /// - Returns:  The new file path.
    public func removingExtension() -> Self {
        Self((string as NSString).deletingPathExtension)
    }

    /// Replaces the current extension of this file path with the provided
    /// extension.
    ///
    /// - Parameter ext:    The replacement extension.
    public mutating func replaceExtension(with ext: String) {
        self = replacingExtension(with: ext)
    }

    /// Returns a new file path made by replacing the current extension of this
    /// file path with the provided extension.
    ///
    /// - Parameter ext:    The replacement extension.
    ///
    /// - Returns:  The new file path.
    public func replacingExtension(with ext: String) -> Self {
        let stripped = (string as NSString).deletingPathExtension

        guard let result = (stripped as NSString).appendingPathExtension(ext)
        else { return self }

        return Self(result)
    }

    /// Resolves all symbolic links in this file path and standardizes it.
    public mutating func resolveSymbolicLinks() {
        self = resolvingSymbolicLinks()
    }

    /// Returns a new file path made by resolving all symbolic links in this
    /// file path and standardizing it.
    ///
    /// - Returns:  The new file path.
    public func resolvingSymbolicLinks() -> Self {
        Self((string as NSString).resolvingSymlinksInPath)
    }

    /// Removes extraneous components from this file path.
    public mutating func standardize() {
        self = standardizing()
    }

    /// Returns a new file path made by removing extraneous components from this
    /// file path.
    ///
    /// - Returns: The new file path.
    public func standardizing() -> Self {
        Self((string as NSString).standardizingPath)
    }
}
