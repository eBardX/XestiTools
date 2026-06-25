// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
 import XestiToolsCore

struct SequenceReaderTests {
}

// MARK: -

extension SequenceReaderTests {
    @Test
    func hasMore_afterExhausted() {
        var reader = SequenceReader([1])

        _ = reader.read()

        #expect(!reader.hasMore)
    }

    @Test
    func hasMore_empty() {
        let reader = SequenceReader([Int]())

        #expect(!reader.hasMore)
    }

    @Test
    func hasMore_withElements() {
        let reader = SequenceReader([1])

        #expect(reader.hasMore)
    }

    @Test
    func interleavedOperations() {
        var reader = SequenceReader([10, 20, 30, 40])

        #expect(reader.peek() == 10)
        #expect(reader.read() == 10)

        let didSkip = reader.skip()

        #expect(didSkip)
        #expect(reader.peek() == 30)
        #expect(reader.hasMore)
        #expect(reader.read() == 30)
        #expect(reader.read() == 40)
        #expect(!reader.hasMore)
    }

    @Test
    func peek_afterRead() {
        var reader = SequenceReader([1, 2, 3])

        _ = reader.read()

        #expect(reader.peek() == 2)
    }

    @Test
    func peek_doesNotAdvance() {
        let reader = SequenceReader([10, 20])

        #expect(reader.peek() == 10)
        #expect(reader.peek() == 10)
    }

    @Test
    func peek_emptySequence() {
        let reader = SequenceReader([Int]())

        #expect(reader.peek() == nil)
    }

    @Test
    func read_allElements() {
        var reader = SequenceReader([1, 2, 3])

        #expect(reader.read() == 1)
        #expect(reader.read() == 2)
        #expect(reader.read() == 3)
        #expect(reader.read() == nil)
    }

    @Test
    func read_stringSequence() {
        var reader = SequenceReader(["a", "b", "c"])

        #expect(reader.read() == "a")
        #expect(reader.read() == "b")
        #expect(reader.read() == "c")
        #expect(reader.read() == nil)
    }

    @Test
    func skip_advancesWithoutReturningValue() {
        var reader = SequenceReader([1, 2, 3])

        let didSkip = reader.skip()

        #expect(didSkip)
        #expect(reader.peek() == 2)
    }

    @Test
    func skip_returnsFalseWhenEmpty() {
        var reader = SequenceReader([Int]())

        let didSkip = reader.skip()

        #expect(!didSkip)
    }

    @Test
    func skip_returnsTrueAndExhausts() {
        var reader = SequenceReader([42])

        let didSkip = reader.skip()

        #expect(didSkip)
        #expect(!reader.hasMore)

        let didSkipAgain = reader.skip()

        #expect(!didSkipAgain)
    }
}
