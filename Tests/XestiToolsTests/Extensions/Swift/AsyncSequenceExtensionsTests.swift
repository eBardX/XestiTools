// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct AsyncSequenceExtensionsTests {
}

// MARK: -

extension AsyncSequenceExtensionsTests {
    @Test
    func jsonValues_decodesCustomDecodableType() async {
        let stream = makeByteStream(Array("5\n".utf8))
        let sequence: AsyncJSONValueSequence<AsyncStream<UInt8>, TestIntType> = stream.jsonValues()

        var iterator = sequence.makeAsyncIterator()
        let result = await iterator.next()

        #expect(result?.intValue == 5)
    }

    @Test
    func jsonValues_decodesLines() async throws {
        let stream = makeByteStream(Array("1\n2\n3\n".utf8))
        let sequence: AsyncJSONValueSequence<AsyncStream<UInt8>, Int> = stream.jsonValues()

        var results: [Int] = []

        for try await value in sequence {
            results.append(value)
        }

        #expect(results == [1, 2, 3])
    }
}
