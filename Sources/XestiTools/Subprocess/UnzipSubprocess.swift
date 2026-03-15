// © 2024–2026 John Gary Pusey (see LICENSE.md)

#if os(macOS)
import System

/// A subprocess that extracts files from a ZIP archive.
///
/// The `UnzipSubprocess` class performs the equivalent of:
/// 
/// ```bash
/// unzip -q <zip-path> -d <destination-path>
/// ```
public final class UnzipSubprocess: Subprocess {

    // MARK: Public Initializers

    /// Creates a new `UnzipSubprocess` instance.
    ///
    /// - Parameter zipPath:                The location of the ZIP archive.
    /// - Parameter destinationPath:        The location of the directory to
    ///                                     extract files to.
    /// - Parameter currentDirectoryPath:   The location of the current
    ///                                     directory. Defaults to `nil`.
    /// - Parameter standardIO:             Standard I/O for the new subprocess.
    ///                                     By default, standard I/O is
    ///                                     inherited from the creating process.
    ///                                     See ``StandardIO``.
    public init(zipPath: FilePath,
                destinationPath: FilePath,
                currentDirectoryPath: FilePath? = nil,
                standardIO: StandardIO = StandardIO()) {
        super.init(executablePath: FilePath("/usr/bin/unzip"),
                   arguments: ["-q",
                               zipPath.absolute().string,
                               "-d",
                               destinationPath.absolute().string],
                   currentDirectoryPath: currentDirectoryPath,
                   standardIO: standardIO)
    }
}
#endif
