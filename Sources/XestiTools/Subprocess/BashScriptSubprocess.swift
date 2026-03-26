// © 2020–2026 John Gary Pusey (see LICENSE.md)

#if os(macOS)
public import System

/// A subprocess that runs a Bash script.
open class BashScriptSubprocess: Subprocess {

    // MARK: Public Initializers

    /// Creates a new `BashScriptSubprocess` instance.
    /// 
    /// - Parameter scriptPath:             The location of the Bash script.
    /// - Parameter arguments:              An array of strings that supplies
    ///                                     the command arguments. Defaults to
    ///                                     an empty array.
    /// - Parameter currentDirectoryPath:    The location of the current
    ///                                     directory. Defaults to `nil`.
    /// - Parameter environment:            A dictionary of environment variable
    ///                                     values whose keys are the variable
    ///                                     names. By default, the environment
    ///                                     is inherited from the creating
    ///                                     process.
    /// - Parameter standardIO:             Standard I/O for the new subprocess.
    ///                                     By default, standard I/O is
    ///                                     inherited from the creating process.
    ///                                     See ``StandardIO``.
    public init(scriptPath: FilePath,
                arguments: [String] = [],
                currentDirectoryPath: FilePath? = nil,
                environment: [String: String]? = nil,
                standardIO: StandardIO = StandardIO()) {
        var command = Self._quote(scriptPath.absolute().string)

        command.append(" ")
        command.append(arguments.map(Self._quote).joined(separator: " "))

        super.init(executablePath: FilePath("/bin/bash"),
                   arguments: ["-c", command],
                   currentDirectoryPath: currentDirectoryPath,
                   environment: environment,
                   standardIO: standardIO)
    }

    // MARK: Private Type Methods

    private static func _quote(_ value: String) -> String {
        "'" + value.split(separator: "'",
                          omittingEmptySubsequences: false).joined(separator: "'\\''") + "'"
    }
}
#endif
