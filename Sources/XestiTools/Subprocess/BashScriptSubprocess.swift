// © 2020–2024 John Gary Pusey (see LICENSE.md)

#if os(macOS)
import System

open class BashScriptSubprocess: Subprocess {

    // MARK: Public Initializers

    public init(scriptPath: FilePath,
                arguments: [String] = [],
                currentDirectoryPath: FilePath? = nil,
                environment: [String: String]? = nil,
                standardIO: StandardIO = .init()) {
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
        var result = ""

        result.append("\"")
        result.append(value)
        result.append("\"")

        return result
    }
}
#endif
