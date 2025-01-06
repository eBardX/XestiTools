// © 2024 John Gary Pusey (see LICENSE.md)

import Foundation

extension NSError: EnhancedError {
    public var cause: (any EnhancedError)? {
        userInfo[NSUnderlyingErrorKey] as? (any EnhancedError)
    }

    public var message: String {
        localizedDescription
    }
}
