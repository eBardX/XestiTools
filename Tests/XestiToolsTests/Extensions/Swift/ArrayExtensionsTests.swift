// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct ArrayExtensionsTests {
}

// MARK: -

extension ArrayExtensionsTests {
    @Test
    func test_popFromEmptyArray() {
        var array: [Int] = []

        #expect(array.pop() == nil)
        #expect(array.isEmpty)
    }

    @Test
    func test_popFromNonEmptyArray() {
        var array = [1, 2, 3]

        #expect(array.pop() == 3)
        #expect(array == [1, 2])
    }

    @Test
    func test_popFromSingleElementArray() {
        var array = [42]

        #expect(array.pop() == 42)
        #expect(array.isEmpty)
    }

    @Test
    func test_push() {
        var array = [1, 2]

        array.push(3)

        #expect(array == [1, 2, 3])
    }

    @Test
    func test_pushPopSequence() {
        var array: [String] = []

        array.push("a")
        array.push("b")
        array.push("c")

        #expect(array.top() == "c")
        #expect(array.pop() == "c")
        #expect(array.pop() == "b")
        #expect(array.top() == "a")
        #expect(array.pop() == "a")
        #expect(array.pop() == nil)
    }

    @Test
    func test_pushToEmptyArray() {
        var array: [Int] = []

        array.push(1)

        #expect(array == [1])
    }

    @Test
    func test_topFromEmptyArray() {
        let array: [Int] = []

        #expect(array.top() == nil)
    }

    @Test
    func test_topFromNonEmptyArray() {
        let array = [1, 2, 3]

        #expect(array.top() == 3)
    }
}
