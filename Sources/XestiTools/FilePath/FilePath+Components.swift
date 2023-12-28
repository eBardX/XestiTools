// © 2023 J. G. Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {

    // MARK: Public Type Methods

    public static func + (lhs: FilePath,
                          rhs: FilePath) -> FilePath {
        lhs.pushing(rhs)
    }

    // MARK: Public Instance Properties

    public var fileURL: URL {
        URL(self)!  // swiftlint:disable:this force_unwrapping
    }

    // MARK: Public Instance Methods

    public mutating func abbreviateWithTilde() {
        self = abbreviatingWithTilde()
    }

    public func abbreviatingWithTilde() -> FilePath {
        FilePath((string as NSString).abbreviatingWithTildeInPath)
    }

    public mutating func appendExtension(_ ext: String) {
        self = appendingExtension(ext)
    }

    public func appendingExtension(_ ext: String) -> FilePath {
        guard let result = (string as NSString).appendingPathExtension(ext)
        else { return self }

        return FilePath(result)
    }

    public func expandingTilde() -> FilePath {
        FilePath((string as NSString).expandingTildeInPath)
    }

    public mutating func expandTilde() {
        self = expandingTilde()
    }

    public mutating func resolveSymbolicLinks() {
        self = resolvingSymbolicLinks()
    }

    public func resolvingSymbolicLinks() -> FilePath {
        FilePath((string as NSString).resolvingSymlinksInPath)
    }

    public mutating func standardize() {
        self = standardizing()
    }

    public func standardizing() -> FilePath {
        FilePath((string as NSString).standardizingPath)
    }
}
