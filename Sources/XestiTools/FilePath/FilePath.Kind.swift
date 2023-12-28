// © 2023 J. G. Pusey (see LICENSE.md)

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
            return .typeBlockSpecial

        case .characterSpecial:
            return .typeCharacterSpecial

        case .directory:
            return .typeDirectory

        case .regular:
            return .typeRegular

        case .socket:
            return .typeSocket

        case .symbolicLink:
            return .typeSymbolicLink

        case .unknown:
            return .typeUnknown
        }
    }
}
