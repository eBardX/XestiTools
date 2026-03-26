// © 2018–2026 John Gary Pusey (see LICENSE.md)

#if os(macOS)
public import Foundation
public import System

/// A thin wrapper around the `Process` class.
///
/// The `Subprocess` class provides a simple interface for running another
/// program as a subprocess of the current process.
open class Subprocess {

    // MARK: Public Nested Types

    /// The result of running a `Subprocess` instance.
    ///
    /// `Result` is a tuple comprised of three components:
    ///
    /// - The `status` component contains the exit status returned by the
    ///   executable.
    /// - The `output` component contains the data written by the executable to
    ///   standard output. It may be empty.
    /// - The `error` component contains the data written by the executable to
    ///   standard error. It may be empty.
    public typealias Result = (status: Int, output: Data, error: Data)

    // MARK: Public Initializers

    /// Creates a new `Subprocess` instance.
    ///
    /// - Parameter executablePath:         The location of the executable.
    /// - Parameter arguments:              An array of strings that supplies
    ///                                     the command arguments. Defaults to
    ///                                     an empty array.
    /// - Parameter currentDirectoryPath:   The location of the current
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
    public init(executablePath: FilePath,
                arguments: [String] = [],
                currentDirectoryPath: FilePath? = nil,
                environment: [String: String]? = nil,
                standardIO: StandardIO = StandardIO()) {
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

    /// Launches the executable as a subprocess and waits until it is finished.
    public func execute() throws {
        try process.run()

        process.waitUntilExit()
    }

    /// Launches the executable as a subprocess, waits until it is finished, and
    /// returns the result.
    ///
    /// - Returns:  A ``Result`` tuple.
    public func run() throws -> Result {
        let dataQueue = DispatchQueue(label: "com.xesticode.Subprocess.dataQueue",
                                      qos: .userInteractive,
                                      target: .global(qos: .userInteractive))

        nonisolated(unsafe) var outputData = Data()
        nonisolated(unsafe) var errorData = Data()

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

        try process.run()

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
