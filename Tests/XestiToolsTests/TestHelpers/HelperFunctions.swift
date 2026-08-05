// © 2026 John Gary Pusey (see LICENSE.md)

import Dispatch
import Foundation
import System
import XestiTools

func makeByteStream(_ bytes: [UInt8]) -> AsyncStream<UInt8> {
    AsyncStream { continuation in
        for byte in bytes {
            continuation.yield(byte)
        }

        continuation.finish()
    }
}

func makeTemporaryDirectory() throws -> FilePath {
    let path = FilePath.uniqueTemporaryDirectory

    try path.createDirectory()

    return path
}

func makeWritableFileHandle(in directory: FilePath) throws -> FileHandle {
    let path = directory.appending(UUID().uuidString)

    try path.writeData(Data())

    return try FileHandle(forWritingTo: path.fileURL)
}

func readAvailableData(from pipe: Pipe,
                       timeout: TimeInterval = 1.0) -> Data {
    nonisolated(unsafe) var result = Data()
    let semaphore = DispatchSemaphore(value: 0)

    DispatchQueue.global().async {
        result = pipe.fileHandleForReading.availableData
        semaphore.signal()
    }

    _ = semaphore.wait(timeout: .now() + timeout)

    return result
}
