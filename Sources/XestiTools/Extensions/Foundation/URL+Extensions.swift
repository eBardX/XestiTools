// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension URL {

    // MARK: Public Type Methods

    public static func createTemporaryReplacementDirectory() throws -> URL {
        try FileManager.default.url(for: .itemReplacementDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: _documentDirectory(),
                                    create: true)
    }

    // MARK: Private Type Methods

    private static func _documentDirectory() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
    }
}
