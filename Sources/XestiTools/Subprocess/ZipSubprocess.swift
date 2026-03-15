// © 2024–2026 John Gary Pusey (see LICENSE.md)

#if os(macOS)
import System

/// A subprocess that compresses a directory into a ZIP archive.
///
/// The `ZipSubprocess` class performs the equivalent of:
///
/// ```bash
/// zip -qry <zip-path> <source-path>
/// ```
public final class ZipSubprocess: Subprocess {

    // MARK: Public Initializers

    /// Creates a new `ZipSubprocess` instance.
    ///
    /// - Parameter sourcePath:             The location of the directory to
    ///                                     compress.
    /// - Parameter zipPath:                The location of the ZIP archive.
    /// - Parameter currentDirectoryPath:   The location of the current
    ///                                     directory. Defaults to `nil`.
    /// - Parameter standardIO:             Standard I/O for the new subprocess.
    ///                                     By default, standard I/O is
    ///                                     inherited from the creating process.
    ///                                     See ``StandardIO``.
    public init(sourcePath: FilePath,
                zipPath: FilePath,
                currentDirectoryPath: FilePath? = nil,
                standardIO: StandardIO = StandardIO()) {
        //
        // NOTE: Do NOT attempt to force `sourcePath` to be _absolute_,
        //       that can cause bad shit to happen!
        //
        super.init(executablePath: FilePath("/usr/bin/zip"),
                   arguments: ["-qry",
                               zipPath.absolute().string,
                               sourcePath.string],
                   currentDirectoryPath: currentDirectoryPath,
                   standardIO: standardIO)
    }
}
#endif
