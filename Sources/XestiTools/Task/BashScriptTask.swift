// © 2020–2023 J. G. Pusey (see LICENSE.md)

import System

open class BashScriptTask: SubprocessTask {

    // MARK: Public Initializers

    public init(scriptPath: FilePath,
                arguments: [String],
                currentDirectoryPath: FilePath? = nil) {
        var command = Self._quote(scriptPath.absolute().string)

        command.append(" ")
        command.append(arguments.map(Self._quote).joined(separator: " "))

        super.init(executablePath: FilePath("/bin/bash"),
                   arguments: ["-c", command],
                   currentDirectoryPath: currentDirectoryPath)
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
