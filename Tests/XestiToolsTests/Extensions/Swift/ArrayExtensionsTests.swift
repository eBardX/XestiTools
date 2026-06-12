// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct ArrayExtensionsTests {
}

// MARK: -

extension ArrayExtensionsTests {
    @Test
    func pop_emptyArray() {
        var array: [Int] = []

        #expect(array.pop() == nil)
        #expect(array.isEmpty)
    }

    @Test
    func pop_nonEmptyArray() {
        var array = [1, 2, 3]

        #expect(array.pop() == 3)
        #expect(array == [1, 2])
    }

    @Test
    func pop_singleElementArray() {
        var array = [42]

        #expect(array.pop() == 42)
        #expect(array.isEmpty)
    }

    @Test
    func push() {
        var array = [1, 2]

        array.push(3)

        #expect(array == [1, 2, 3])
    }

    @Test
    func pushPop_sequence() {
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
    func push_emptyArray() {
        var array: [Int] = []

        array.push(1)

        #expect(array == [1])
    }

    @Test
    func top_emptyArray() {
        let array: [Int] = []

        #expect(array.top() == nil)
    }

    @Test
    func top_nonEmptyArray() {
        let array = [1, 2, 3]

        #expect(array.top() == 3)
    }
}
