// © 2023–2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension NSNumber {
    public var isBoolean: Bool {
        objCType == Self.booleanObjCType
    }

    // MARK: Private Type Properties

    private static var booleanObjCType = NSNumber(value: true).objCType
}
