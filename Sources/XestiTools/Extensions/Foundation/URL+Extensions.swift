// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension URL {

    // MARK: Public Type Methods

    /// Creates a new temporary replacement directory appropriate for the
    /// document directory.
    ///
    /// - Returns:  The file URL of the created directory.
    ///
    /// - Throws:   An error if the directory cannot be created.
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
