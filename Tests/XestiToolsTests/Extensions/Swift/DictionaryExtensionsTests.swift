// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct DictionaryExtensionsTests {
}

// MARK: -

extension DictionaryExtensionsTests {
    @Test
    func test_compactMapKeys() {
        let dict = ["1": "a", "two": "b", "3": "c"]
        let result = dict.compactMapKeys { Int($0) }

        #expect(result == [1: "a", 3: "c"])
    }

    @Test
    func test_compactMapKeysAllNil() {
        let dict = ["a": 1, "b": 2]
        let result = dict.compactMapKeys { _ -> Int? in nil }

        #expect(result.isEmpty)
    }

    @Test
    func test_compactMapKeysEmptyDictionary() {
        let dict: [String: Int] = [:]
        let result = dict.compactMapKeys { Int($0) }

        #expect(result.isEmpty)
    }

    @Test
    func test_compactMapKeysNoneNil() {
        let dict = [1: "x", 2: "y"]
        let result = dict.compactMapKeys { String($0) }

        #expect(result == ["1": "x", "2": "y"])
    }

    @Test
    func test_mapKeys() {
        let dict = ["a": 1, "b": 2, "c": 3]
        let result = dict.mapKeys { $0.uppercased() }

        #expect(result == ["A": 1, "B": 2, "C": 3])
    }

    @Test
    func test_mapKeysCollision() {
        let dict = ["a": 1, "A": 2]
        let result = dict.mapKeys { $0.lowercased() }

        #expect(result.count == 1)
        #expect(result["a"] == 1 || result["a"] == 2)
    }

    @Test
    func test_mapKeysEmptyDictionary() {
        let dict: [String: Int] = [:]
        let result = dict.mapKeys { $0.uppercased() }

        #expect(result.isEmpty)
    }

    @Test
    func test_mapKeysToIntKeys() {
        let dict = ["1": "a", "2": "b"]
        let result = dict.mapKeys { Int($0)! }  // swiftlint:disable:this force_unwrapping

        #expect(result == [1: "a", 2: "b"])
    }
}
