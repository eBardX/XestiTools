// © 2024–2026 John Gary Pusey (see LICENSE.md)

#if os(macOS)
import System

public final class UnzipSubprocess: Subprocess {

    // MARK: Public Initializers

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
