// © 2023–2026 John Gary Pusey (see LICENSE.md)

import Foundation

extension NSNumber {
    /// A Boolean value indicating whether this `NSNumber` instance was created
    /// from a `Bool` value.
    public var isBoolean: Bool {
        objCType == Self.booleanObjCType
    }

    // MARK: Private Type Properties

    nonisolated(unsafe) private static let booleanObjCType = NSNumber(value: true).objCType
}
