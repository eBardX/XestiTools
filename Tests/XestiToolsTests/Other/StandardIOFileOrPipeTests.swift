// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct StandardIOFileOrPipeTests {
}

// MARK: -

extension StandardIOFileOrPipeTests {
    @Test
    func fileHandleForReading_file() {
        let handle = FileHandle.nullDevice
        let fileOrPipe = StandardIO.FileOrPipe.file(handle)

        #expect(fileOrPipe.fileHandleForReading === handle)
    }

    @Test
    func fileHandleForReading_pipe() {
        let pipe = Pipe()
        let fileOrPipe = StandardIO.FileOrPipe.pipe(pipe)

        #expect(fileOrPipe.fileHandleForReading === pipe.fileHandleForReading)
    }

    @Test
    func fileHandleForWriting_file() {
        let handle = FileHandle.nullDevice
        let fileOrPipe = StandardIO.FileOrPipe.file(handle)

        #expect(fileOrPipe.fileHandleForWriting === handle)
    }

    @Test
    func fileHandleForWriting_pipe() {
        let pipe = Pipe()
        let fileOrPipe = StandardIO.FileOrPipe.pipe(pipe)

        #expect(fileOrPipe.fileHandleForWriting === pipe.fileHandleForWriting)
    }

    @Test
    func value_file() {
        let handle = FileHandle.nullDevice
        let fileOrPipe = StandardIO.FileOrPipe.file(handle)

        #expect(fileOrPipe.value as? FileHandle === handle)
    }

    @Test
    func value_pipe() {
        let pipe = Pipe()
        let fileOrPipe = StandardIO.FileOrPipe.pipe(pipe)

        #expect(fileOrPipe.value as? Pipe === pipe)
    }
}
