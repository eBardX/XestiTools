// © 2024–2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension UUID {

    // MARK: Public Instance Properties

    public var hexString: String {
        uuidString.replacingOccurrences(of: "-",
                                        with: "").lowercased()
    }
}
