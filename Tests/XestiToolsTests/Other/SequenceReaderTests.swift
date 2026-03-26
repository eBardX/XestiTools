// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct SequenceReaderTests {
}

// MARK: -

extension SequenceReaderTests {
    @Test
    func test_hasMoreAfterExhausted() {
        var reader = SequenceReader([1])

        _ = reader.read()

        #expect(!reader.hasMore)
    }

    @Test
    func test_hasMoreWhenEmpty() {
        let reader = SequenceReader([Int]())

        #expect(!reader.hasMore)
    }

    @Test
    func test_hasMoreWithElements() {
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
    func test_peekAfterRead() {
        var reader = SequenceReader([1, 2, 3])

        _ = reader.read()

        #expect(reader.peek() == 2)
    }

    @Test
    func test_peekDoesNotAdvance() {
        let reader = SequenceReader([10, 20])

        #expect(reader.peek() == 10)
        #expect(reader.peek() == 10)
    }

    @Test
    func test_peekOnEmptySequence() {
        let reader = SequenceReader([Int]())

        #expect(reader.peek() == nil)
    }

    @Test
    func test_readAllElements() {
        var reader = SequenceReader([1, 2, 3])

        #expect(reader.read() == 1)
        #expect(reader.read() == 2)
        #expect(reader.read() == 3)
        #expect(reader.read() == nil)
    }

    @Test
    func test_readStringSequence() {
        var reader = SequenceReader(["a", "b", "c"])

        #expect(reader.read() == "a")
        #expect(reader.read() == "b")
        #expect(reader.read() == "c")
        #expect(reader.read() == nil)
    }

    @Test
    func test_skipAdvancesWithoutReturningValue() {
        var reader = SequenceReader([1, 2, 3])

        let didSkip = reader.skip()

        #expect(didSkip)
        #expect(reader.peek() == 2)
    }

    @Test
    func test_skipReturnsFalseWhenEmpty() {
        var reader = SequenceReader([Int]())

        let didSkip = reader.skip()

        #expect(!didSkip)
    }

    @Test
    func test_skipReturnsTrueAndExhausts() {
        var reader = SequenceReader([42])

        let didSkip = reader.skip()

        #expect(didSkip)
        #expect(!reader.hasMore)

        let didSkipAgain = reader.skip()

        #expect(!didSkipAgain)
    }
}
