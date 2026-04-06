// © 2024–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct SubstringExtensionsTests {
}

// MARK: -

extension SubstringExtensionsTests {
    @Test
    func test_dropPrefix_allMatchingCharacters() {
        let example = Substring("###########")
        let expected = Substring("")

        #expect(example.dropPrefix("#") == expected)
    }

    @Test
    func test_dropPrefix_characterSet() {
        let example = Substring("***###hello")
        let expected = Substring("hello")

        #expect(example.dropPrefix(Set<Character>(["*", "#"])) == expected)
    }

    @Test
    func test_dropPrefix_emptyString() {
        let example = Substring("")
        let expected = Substring("")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func test_dropPrefix_leadingMatch() {
        let example = Substring("***fu*bar***")
        let expected = Substring("fu*bar***")

        #expect(example.dropPrefix("*") == expected)
    }

    @Test
    func test_dropPrefix_leadingMatchDollar() {
        let example = Substring("$goo$ber$")
        let expected = Substring("goo$ber$")

        #expect(example.dropPrefix("$") == expected)
    }

    @Test
    func test_dropPrefix_noMatch() {
        let example = Substring("pris@tine")
        let expected = Substring("pris@tine")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func test_dropPrefix_noMatchSingleChar() {
        let example = Substring("1")
        let expected = Substring("1")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func test_dropSuffix_allMatchingCharacters() {
        let example = Substring("###########")
        let expected = Substring("")

        #expect(example.dropSuffix("#") == expected)
    }

    @Test
    func test_dropSuffix_characterSet() {
        let example = Substring("hello***###")
        let expected = Substring("hello")

        #expect(example.dropSuffix(Set<Character>(["*", "#"])) == expected)
    }

    @Test
    func test_dropSuffix_emptyString() {
        let example = Substring("")
        let expected = Substring("")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func test_dropSuffix_noMatch() {
        let example = Substring("pris@tine")
        let expected = Substring("pris@tine")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func test_dropSuffix_noMatchSingleChar() {
        let example = Substring("1")
        let expected = Substring("1")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func test_dropSuffix_trailingMatch() {
        let example = Substring("***fu*bar***")
        let expected = Substring("***fu*bar")

        #expect(example.dropSuffix("*") == expected)
    }

    @Test
    func test_dropSuffix_trailingMatchDollar() {
        let example = Substring("$goo$ber$")
        let expected = Substring("$goo$ber")

        #expect(example.dropSuffix("$") == expected)
    }

    @Test
    func test_location_atStart() {
        let str = "hello world"
        let sub = str[str.startIndex...]

        #expect(sub.location.line == 1)
        #expect(sub.location.column == 1)
    }

    @Test
    func test_location_inMiddle() {
        let str = "hello world"
        let idx = str.index(str.startIndex, offsetBy: 6)
        let sub = str[idx...]

        #expect(sub.location.line == 1)
        #expect(sub.location.column == 7)
    }

    @Test
    func test_splitBeforeFirst_atEnd() {
        let example = Substring("hello:")
        let result = example.splitBeforeFirst(":")

        #expect(result.head == "hello")
        #expect(result.tail == ":")
    }

    @Test
    func test_splitBeforeFirst_atStart() {
        let example = Substring(":hello")
        let result = example.splitBeforeFirst(":")

        #expect(result.head.isEmpty)
        #expect(result.tail == ":hello")
    }

    @Test
    func test_splitBeforeFirst_characterSet() {
        let example = Substring("hello=world")
        let result = example.splitBeforeFirst(Set<Character>([":", "="]))

        #expect(result.head == "hello")
        #expect(result.tail == "=world")
    }

    @Test
    func test_splitBeforeFirst_emptyString() {
        let example = Substring("")
        let result = example.splitBeforeFirst(":")

        #expect(result.head.isEmpty)
        #expect(result.tail == nil)
    }

    @Test
    func test_splitBeforeFirst_found() {
        let example = Substring("hello:world")
        let result = example.splitBeforeFirst(":")

        #expect(result.head == "hello")
        #expect(result.tail == ":world")
    }

    @Test
    func test_splitBeforeFirst_notFound() {
        let example = Substring("helloworld")
        let result = example.splitBeforeFirst(":")

        #expect(result.head == "helloworld")
        #expect(result.tail == nil)
    }
}
