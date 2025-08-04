// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

public struct ICloudIdentity {

    // MARK: Public Nested Types

    public typealias Token = any NSCoding & NSCopying & NSObjectProtocol

    // MARK: Public Initializers

    public init(_ token: Token) {
        self.token = token
    }

    // MARK: Public Instance Properties

    public let token: Token
}

// MARK: - Equatable

extension ICloudIdentity: Equatable {
    public static func == (_ lhs: Self,
                           _ rhs: Self) -> Bool {
        lhs.token.isEqual(rhs.token)
    }
}
