// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct AsyncJSONValueSequenceTests {
}

// MARK: -

extension AsyncJSONValueSequenceTests {
    @Test
    func makeAsyncIterator() async throws {
        let stream = makeByteStream(Array("1\n2\n".utf8))
        let sequence: AsyncJSONValueSequence<AsyncStream<UInt8>, Int> = stream.jsonValues()

        var iterator = sequence.makeAsyncIterator()

        let first = try await iterator.next()
        let second = try await iterator.next()
        let third = try await iterator.next()

        #expect(first == 1)
        #expect(second == 2)
        #expect(third == nil)
    }
}
