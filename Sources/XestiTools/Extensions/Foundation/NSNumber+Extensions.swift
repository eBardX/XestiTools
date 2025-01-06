// © 2023–2024 John Gary Pusey (see LICENSE.md)

import Foundation

extension NSNumber {
    public var isBoolean: Bool {
        type(of: self) == type(of: NSNumber(value: true))
    }
}
