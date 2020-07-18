// © 2018–2020 J. G. Pusey (see LICENSE.md)

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
