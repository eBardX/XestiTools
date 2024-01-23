// © 2024 John Gary Pusey (see LICENSE.md)

#if os(macOS)
import System

public final class ZipSubprocess: Subprocess {

    // MARK: Public Initializers

    public init(sourcePath: FilePath,
                zipPath: FilePath,
                currentDirectoryPath: FilePath? = nil,
                standardIO: StandardIO = .init()) {
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
