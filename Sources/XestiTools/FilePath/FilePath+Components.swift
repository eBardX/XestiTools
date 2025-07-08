// © 2024 John Gary Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {

    // MARK: Public Instance Properties

    public var baseName: String {
        (string as NSString).lastPathComponent
    }

    public var fileURL: URL {
        if #available(macOS 13.0, iOS 16.0, *) {
            URL(filePath: self)!    // swiftlint:disable:this force_unwrapping
        } else {
            URL(self)!              // swiftlint:disable:this force_unwrapping
        }
    }

    // MARK: Public Instance Methods

    public mutating func abbreviateWithTilde() {
        self = abbreviatingWithTilde()
    }

    public func abbreviatingWithTilde() -> Self {
        Self((string as NSString).abbreviatingWithTildeInPath)
    }

    public mutating func appendExtension(_ ext: String) {
        self = appendingExtension(ext)
    }

    public func appendingExtension(_ ext: String) -> Self {
        guard let result = (string as NSString).appendingPathExtension(ext)
        else { return self }

        return Self(result)
    }

    public func expandingTilde() -> Self {
        Self((string as NSString).expandingTildeInPath)
    }

    public mutating func expandTilde() {
        self = expandingTilde()
    }

    public mutating func removeExtension() {
        self = removingExtension()
    }

    public func removingExtension() -> Self {
        Self((string as NSString).deletingPathExtension)
    }

    public mutating func replaceExtension(with ext: String) {
        self = replacingExtension(with: ext)
    }

    public func replacingExtension(with ext: String) -> Self {
        let stripped = (string as NSString).deletingPathExtension

        guard let result = (stripped as NSString).appendingPathExtension(ext)
        else { return self }

        return Self(result)
    }

    public mutating func resolveSymbolicLinks() {
        self = resolvingSymbolicLinks()
    }

    public func resolvingSymbolicLinks() -> Self {
        Self((string as NSString).resolvingSymlinksInPath)
    }

    public mutating func standardize() {
        self = standardizing()
    }

    public func standardizing() -> Self {
        Self((string as NSString).standardizingPath)
    }
}
