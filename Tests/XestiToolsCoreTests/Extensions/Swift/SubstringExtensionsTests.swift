// © 2024–2026 John Gary Pusey (see LICENSE.md)

import Testing
 import XestiToolsCore

struct SubstringExtensionsTests {
}

// MARK: -

extension SubstringExtensionsTests {
    @Test
    func dropPrefix_allMatchingCharacters() {
        let example = Substring("###########")
        let expected = Substring("")

        #expect(example.dropPrefix("#") == expected)
    }

    @Test
    func dropPrefix_characterSet() {
        let example = Substring("***###hello")
        let expected = Substring("hello")

        #expect(example.dropPrefix(Set<Character>(["*", "#"])) == expected)
    }

    @Test
    func dropPrefix_emptyString() {
        let example = Substring("")
        let expected = Substring("")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func dropPrefix_leadingMatch() {
        let example = Substring("***fu*bar***")
        let expected = Substring("fu*bar***")

        #expect(example.dropPrefix("*") == expected)
    }

    @Test
    func dropPrefix_leadingMatchDollar() {
        let example = Substring("$goo$ber$")
        let expected = Substring("goo$ber$")

        #expect(example.dropPrefix("$") == expected)
    }

    @Test
    func dropPrefix_noMatch() {
        let example = Substring("pris@tine")
        let expected = Substring("pris@tine")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func dropPrefix_noMatchSingleChar() {
        let example = Substring("1")
        let expected = Substring("1")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func dropSuffix_allMatchingCharacters() {
        let example = Substring("###########")
        let expected = Substring("")

        #expect(example.dropSuffix("#") == expected)
    }

    @Test
    func dropSuffix_characterSet() {
        let example = Substring("hello***###")
        let expected = Substring("hello")

        #expect(example.dropSuffix(Set<Character>(["*", "#"])) == expected)
    }

    @Test
    func dropSuffix_emptyString() {
        let example = Substring("")
        let expected = Substring("")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func dropSuffix_noMatch() {
        let example = Substring("pris@tine")
        let expected = Substring("pris@tine")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func dropSuffix_noMatchSingleChar() {
        let example = Substring("1")
        let expected = Substring("1")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func dropSuffix_trailingMatch() {
        let example = Substring("***fu*bar***")
        let expected = Substring("***fu*bar")

        #expect(example.dropSuffix("*") == expected)
    }

    @Test
    func dropSuffix_trailingMatchDollar() {
        let example = Substring("$goo$ber$")
        let expected = Substring("$goo$ber")

        #expect(example.dropSuffix("$") == expected)
    }

    @Test
    func location_atStart() {
        let str = "hello world"
        let sub = str[str.startIndex...]

        #expect(sub.location.line == 1)
        #expect(sub.location.column == 1)
    }

    @Test
    func location_inMiddle() {
        let str = "hello world"
        let idx = str.index(str.startIndex, offsetBy: 6)
        let sub = str[idx...]

        #expect(sub.location.line == 1)
        #expect(sub.location.column == 7)
    }

    @Test
    func splitBeforeFirst_atEnd() {
        let example = Substring("hello:")
        let result = example.splitBeforeFirst(":")

        #expect(result.head == "hello")
        #expect(result.tail == ":")
    }

    @Test
    func splitBeforeFirst_atStart() {
        let example = Substring(":hello")
        let result = example.splitBeforeFirst(":")

        #expect(result.head.isEmpty)
        #expect(result.tail == ":hello")
    }

    @Test
    func splitBeforeFirst_characterSet() {
        let example = Substring("hello=world")
        let result = example.splitBeforeFirst(Set<Character>([":", "="]))

        #expect(result.head == "hello")
        #expect(result.tail == "=world")
    }

    @Test
    func splitBeforeFirst_emptyString() {
        let example = Substring("")
        let result = example.splitBeforeFirst(":")

        #expect(result.head.isEmpty)
        #expect(result.tail == nil)
    }

    @Test
    func splitBeforeFirst_found() {
        let example = Substring("hello:world")
        let result = example.splitBeforeFirst(":")

        #expect(result.head == "hello")
        #expect(result.tail == ":world")
    }

    @Test
    func splitBeforeFirst_notFound() {
        let example = Substring("helloworld")
        let result = example.splitBeforeFirst(":")

        #expect(result.head == "helloworld")
        #expect(result.tail == nil)
    }
}
