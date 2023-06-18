// © 2018–2022 J. G. Pusey (see LICENSE.md)

import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")    // swiftlint:disable:this nslocalizedstring_key
    }
}
