// © 2018–2024 John Gary Pusey (see LICENSE.md)

#if os(macOS)
import Foundation
import System

open class Subprocess {

    // MARK: Public Nested Types

    public typealias Result = (status: Int, output: Data, error: Data)

    // MARK: Public Initializers

    public init(executablePath: FilePath,
                arguments: [String] = [],
                currentDirectoryPath: FilePath? = nil,
                environment: [String: String]? = nil,
                standardIO: StandardIO = .init()) {
        self.process = Process()

        self.process.arguments = arguments

        if let cdPath = currentDirectoryPath {
            process.currentDirectoryURL = cdPath.absolute().fileURL
        }

        if let env = environment {
            self.process.environment = env
        }

        self.process.executableURL = executablePath.absolute().fileURL
        self.process.standardError = standardIO.standardError.value
        self.process.standardInput = standardIO.standardInput.value
        self.process.standardOutput = standardIO.standardOutput.value
    }

    // MARK: Public Instance Methods

    public func execute() throws {
        process.launch()
        process.waitUntilExit()
    }

    public func run() throws -> Result {
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
            }
        }

        errorPipe.fileHandleForReading.readabilityHandler = {
            let data = $0.availableData

            dataQueue.async {
                errorData.append(data)
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
#endif
