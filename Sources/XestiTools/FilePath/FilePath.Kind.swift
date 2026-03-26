// © 2023–2026 John Gary Pusey (see LICENSE.md)

public import Foundation
public import System

extension FilePath {

    // MARK: Public Nested Types

    /// A representation of a file’s kind.
    public enum Kind {
        /// A block special file.
        case blockSpecial

        /// A character special file.
        case characterSpecial

        /// A directory.
        case directory

        /// A regular file.
        case regular

        /// A socket.
        case socket

        /// A symbolic link.
        case symbolicLink

        /// A file whose kind is unknown.
        case unknown
    }
}

extension FilePath.Kind {

    // MARK: Public Initializers

    /// Creates a `Kind` instance from the provided file type attribute value.
    ///
    /// - Parameter type: The file type attribute value.
    public init(_ type: FileAttributeType) {
        switch type {
        case .typeBlockSpecial:
            self = .blockSpecial

        case .typeCharacterSpecial:
            self = .characterSpecial

        case .typeDirectory:
            self = .directory

        case .typeRegular:
            self = .regular

        case .typeSocket:
            self = .socket

        case .typeSymbolicLink:
            self = .symbolicLink

        default:
            self = .unknown
        }
    }

    // MARK: Public Instance Properties

    /// The corresponding file type attribute value.
    public var type: FileAttributeType {
        switch self {
        case .blockSpecial:
                .typeBlockSpecial

        case .characterSpecial:
                .typeCharacterSpecial

        case .directory:
                .typeDirectory

        case .regular:
                .typeRegular

        case .socket:
                .typeSocket

        case .symbolicLink:
                .typeSymbolicLink

        case .unknown:
                .typeUnknown
        }
    }
}

// MARK: - Sendable

extension FilePath.Kind: Sendable {
}
