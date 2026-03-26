// © 2023–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension NSNumber {
    /// A Boolean value indicating whether this `NSNumber` instance was created
    /// from a `Bool` value.
    public var isBoolean: Bool {
        strcmp(objCType, Self.booleanObjCType) == 0
    }

    // MARK: Private Type Properties

    nonisolated(unsafe) private static let booleanObjCType = NSNumber(value: true).objCType
}
