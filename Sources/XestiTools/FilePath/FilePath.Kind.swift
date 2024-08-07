// © 2023–2024 John Gary Pusey (see LICENSE.md)

import Foundation
import System

public extension FilePath {
    enum Kind {
        case blockSpecial
        case characterSpecial
        case directory
        case regular
        case socket
        case symbolicLink
        case unknown
    }
}

public extension FilePath.Kind {
    init(_ type: FileAttributeType) {
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

    var type: FileAttributeType {
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
