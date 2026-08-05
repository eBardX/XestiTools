// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct AsyncJSONValueSequenceTests {
}

// MARK: -

extension AsyncJSONValueSequenceTests {
    @Test
    func next_carriageReturnStripped() async throws {
        let stream = makeByteStream(Array("42\r\n".utf8))
        let sequence: AsyncJSONValueSequence<AsyncStream<UInt8>, Int> = stream.jsonValues()

        var results: [Int] = []

        for try await value in sequence {
            results.append(value)
        }

        #expect(results == [42])
    }

    @Test
    func next_emptyStream() async {
        let stream = makeByteStream([])
        let sequence: AsyncJSONValueSequence<AsyncStream<UInt8>, Int> = stream.jsonValues()

        var iterator = sequence.makeAsyncIterator()
        let result = await iterator.next()

        #expect(result == nil)
    }

    @Test
    func next_multipleLines() async throws {
        let stream = makeByteStream(Array("1\n2\n3\n".utf8))
        let sequence: AsyncJSONValueSequence<AsyncStream<UInt8>, Int> = stream.jsonValues()

        var results: [Int] = []

        for try await value in sequence {
            results.append(value)
        }

        #expect(results == [1, 2, 3])
    }

    @Test
    func next_noTrailingNewline() async throws {
        let stream = makeByteStream(Array("42".utf8))
        let sequence: AsyncJSONValueSequence<AsyncStream<UInt8>, Int> = stream.jsonValues()

        var results: [Int] = []

        for try await value in sequence {
            results.append(value)
        }

        #expect(results == [42])
    }

    @Test
    func next_singleLine() async {
        let stream = makeByteStream(Array("7\n".utf8))
        let sequence: AsyncJSONValueSequence<AsyncStream<UInt8>, Int> = stream.jsonValues()

        var iterator = sequence.makeAsyncIterator()
        let result = await iterator.next()

        #expect(result == 7)
    }
}
