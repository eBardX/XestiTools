// © 2018–2022 J. G. Pusey (see LICENSE.md)

import Foundation
import XestiPath

open class SubprocessTask: Task {

    // MARK: Public Initializers

    public init(executablePath: Path,
                arguments: [String] = [],
                currentDirectoryPath: Path? = nil,
                environment: [String: String]? = nil) {
        self.process = Process()

        self.process.arguments = arguments

        if let cdPath = currentDirectoryPath {
            process.currentDirectoryURL = cdPath.absolute.fileURL
        }

        if let env = environment {
            self.process.environment = env
        }

        self.process.executableURL = executablePath.absolute.fileURL
    }

    // MARK: Public Instance Methods

    @discardableResult
    public func run(outputDataHandler: DataHandler? = nil,
                    errorDataHandler: DataHandler? = nil) throws -> Task.Result {
        let dataQueue = DispatchQueue(label: "com.xesticode.SubprocessTask.dataQueue",
                                      qos: .userInteractive,
                                      target: .global(qos: .userInteractive))

        var outputData = Data()
        var errorData = Data()

        let outputPipe = Pipe()
        let errorPipe = Pipe()
        let inputPipe = Pipe()

        process.standardError = errorPipe
        process.standardInput = inputPipe
        process.standardOutput = outputPipe

        outputPipe.fileHandleForReading.readabilityHandler = {
            let data = $0.availableData

            dataQueue.async {
                outputData.append(data)

                outputDataHandler?(data)
            }
        }

        errorPipe.fileHandleForReading.readabilityHandler = {
            let data = $0.availableData

            dataQueue.async {
                errorData.append(data)

                errorDataHandler?(data)
            }
        }

        process.launch()
        process.waitUntilExit()

        outputPipe.fileHandleForReading.readabilityHandler = nil

        errorPipe.fileHandleForReading.readabilityHandler = nil

        return dataQueue.sync {
            (status: Int(process.terminationStatus),
             output: outputData,
             error: errorData)
        }
    }

    // MARK: Private Instance Properties

    private let process: Process
}
