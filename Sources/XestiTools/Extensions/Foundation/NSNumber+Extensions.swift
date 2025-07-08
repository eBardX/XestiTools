// © 2023–2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension NSNumber {
    public var isBoolean: Bool {
        type(of: self) == type(of: Self(value: true))
    }
}
