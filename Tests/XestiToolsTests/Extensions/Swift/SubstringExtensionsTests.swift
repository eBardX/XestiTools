// © 2024–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct SubstringExtensionsTests {
}

// MARK: -

extension SubstringExtensionsTests {
    @Test
    func test_dropPrefix1() {
        let example = Substring("***fu*bar***")
        let expected = Substring("fu*bar***")

        #expect(example.dropPrefix("*") == expected)
    }

    @Test
    func test_dropPrefix2() {
        let example = Substring("$goo$ber$")
        let expected = Substring("goo$ber$")

        #expect(example.dropPrefix("$") == expected)
    }

    @Test
    func test_dropPrefix3() {
        let example = Substring("###########")
        let expected = Substring("")

        #expect(example.dropPrefix("#") == expected)
    }

    @Test
    func test_dropPrefix4() {
        let example = Substring("pris@tine")
        let expected = Substring("pris@tine")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func test_dropPrefix5() {
        let example = Substring("1")
        let expected = Substring("1")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func test_dropPrefix6() {
        let example = Substring("")
        let expected = Substring("")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func test_dropPrefixWithCharacterSet() {
        let example = Substring("***###hello")
        let expected = Substring("hello")

        #expect(example.dropPrefix(Set<Character>(["*", "#"])) == expected)
    }

    @Test
    func test_dropSuffix1() {
        let example = Substring("***fu*bar***")
        let expected = Substring("***fu*bar")

        #expect(example.dropSuffix("*") == expected)
    }

    @Test
    func test_dropSuffix2() {
        let example = Substring("$goo$ber$")
        let expected = Substring("$goo$ber")

        #expect(example.dropSuffix("$") == expected)
    }

    @Test
    func test_dropSuffix3() {
        let example = Substring("###########")
        let expected = Substring("")

        #expect(example.dropSuffix("#") == expected)
    }

    @Test
    func test_dropSuffix4() {
        let example = Substring("pris@tine")
        let expected = Substring("pris@tine")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func test_dropSuffix5() {
        let example = Substring("1")
        let expected = Substring("1")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func test_dropSuffix6() {
        let example = Substring("")
        let expected = Substring("")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func test_dropSuffixWithCharacterSet() {
        let example = Substring("hello***###")
        let expected = Substring("hello")

        #expect(example.dropSuffix(Set<Character>(["*", "#"])) == expected)
    }

    @Test
    func test_locationAtStart() {
        let str = "hello world"
        let sub = str[str.startIndex...]

        #expect(sub.location.line == 1)
        #expect(sub.location.column == 1)
    }

    @Test
    func test_locationInMiddle() {
        let str = "hello world"
        let idx = str.index(str.startIndex, offsetBy: 6)
        let sub = str[idx...]

        #expect(sub.location.line == 1)
        #expect(sub.location.column == 7)
    }

    @Test
    func test_splitBeforeFirstAtEnd() {
        let example = Substring("hello:")
        let result = example.splitBeforeFirst(":")

        #expect(result.head == "hello")
        #expect(result.tail == ":")
    }

    @Test
    func test_splitBeforeFirstAtStart() {
        let example = Substring(":hello")
        let result = example.splitBeforeFirst(":")

        #expect(result.head.isEmpty)
        #expect(result.tail == ":hello")
    }

    @Test
    func test_splitBeforeFirstEmptyString() {
        let example = Substring("")
        let result = example.splitBeforeFirst(":")

        #expect(result.head.isEmpty)
        #expect(result.tail == nil)
    }

    @Test
    func test_splitBeforeFirstFound() {
        let example = Substring("hello:world")
        let result = example.splitBeforeFirst(":")

        #expect(result.head == "hello")
        #expect(result.tail == ":world")
    }

    @Test
    func test_splitBeforeFirstNotFound() {
        let example = Substring("helloworld")
        let result = example.splitBeforeFirst(":")

        #expect(result.head == "helloworld")
        #expect(result.tail == nil)
    }

    @Test
    func test_splitBeforeFirstWithCharacterSet() {
        let example = Substring("hello=world")
        let result = example.splitBeforeFirst(Set<Character>([":", "="]))

        #expect(result.head == "hello")
        #expect(result.tail == "=world")
    }
}
