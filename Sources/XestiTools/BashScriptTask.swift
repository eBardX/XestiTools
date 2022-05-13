// © 2020–2022 J. G. Pusey (see LICENSE.md)

import XestiPath

open class BashScriptTask: SubprocessTask {

    // MARK: Public Initializers

    public init(scriptPath: Path,
                arguments: [String],
                currentDirectoryPath: Path? = nil) {
        var command = Self._quote(scriptPath.absolute.rawValue)

        command.append(" ")
        command.append(arguments.map(Self._quote).joined(separator: " "))

        super.init(executablePath: Path("/bin/bash"),
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
