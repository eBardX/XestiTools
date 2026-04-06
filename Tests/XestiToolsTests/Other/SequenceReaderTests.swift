// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct SequenceReaderTests {
}

// MARK: -

extension SequenceReaderTests {
    @Test
    func test_hasMore_afterExhausted() {
        var reader = SequenceReader([1])

        _ = reader.read()

        #expect(!reader.hasMore)
    }

    @Test
    func test_hasMore_empty() {
        let reader = SequenceReader([Int]())

        #expect(!reader.hasMore)
    }

    @Test
    func test_hasMore_withElements() {
        let reader = SequenceReader([1])

        #expect(reader.hasMore)
    }

    @Test
    func test_interleavedOperations() {
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
    func test_peek_afterRead() {
        var reader = SequenceReader([1, 2, 3])

        _ = reader.read()

        #expect(reader.peek() == 2)
    }

    @Test
    func test_peek_doesNotAdvance() {
        let reader = SequenceReader([10, 20])

        #expect(reader.peek() == 10)
        #expect(reader.peek() == 10)
    }

    @Test
    func test_peek_emptySequence() {
        let reader = SequenceReader([Int]())

        #expect(reader.peek() == nil)
    }

    @Test
    func test_read_allElements() {
        var reader = SequenceReader([1, 2, 3])

        #expect(reader.read() == 1)
        #expect(reader.read() == 2)
        #expect(reader.read() == 3)
        #expect(reader.read() == nil)
    }

    @Test
    func test_read_stringSequence() {
        var reader = SequenceReader(["a", "b", "c"])

        #expect(reader.read() == "a")
        #expect(reader.read() == "b")
        #expect(reader.read() == "c")
        #expect(reader.read() == nil)
    }

    @Test
    func test_skip_advancesWithoutReturningValue() {
        var reader = SequenceReader([1, 2, 3])

        let didSkip = reader.skip()

        #expect(didSkip)
        #expect(reader.peek() == 2)
    }

    @Test
    func test_skip_returnsFalseWhenEmpty() {
        var reader = SequenceReader([Int]())

        let didSkip = reader.skip()

        #expect(!didSkip)
    }

    @Test
    func test_skip_returnsTrueAndExhausts() {
        var reader = SequenceReader([42])

        let didSkip = reader.skip()

        #expect(didSkip)
        #expect(!reader.hasMore)

        let didSkipAgain = reader.skip()

        #expect(!didSkipAgain)
    }
}
