// © 2018–2023 J. G. Pusey (see LICENSE.md)

import Foundation

extension String {
    public var localized: String {
        NSLocalizedString(self, comment: "")    // swiftlint:disable:this nslocalizedstring_key
    }
}
