// © 2023–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import System

extension FilePath {

    // MARK: Public Nested Types

    public enum Kind {
        case blockSpecial
        case characterSpecial
        case directory
        case regular
        case socket
        case symbolicLink
        case unknown
    }
}

extension FilePath.Kind {

    // MARK: Public Initializers

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
