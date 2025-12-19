// © 2024–2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct SubstringExtensionsTests {
}

// MARK: -

extension SubstringExtensionsTests {
    @Test
    func dropPrefix1() {
        let example = Substring("***fu*bar***")
        let expected = Substring("fu*bar***")

        #expect(example.dropPrefix("*") == expected)
    }

    @Test
    func dropPrefix2() {
        let example = Substring("$goo$ber$")
        let expected = Substring("goo$ber$")

        #expect(example.dropPrefix("$") == expected)
    }

    @Test
    func dropPrefix3() {
        let example = Substring("###########")
        let expected = Substring("")

        #expect(example.dropPrefix("#") == expected)
    }

    @Test
    func dropPrefix4() {
        let example = Substring("pris@tine")
        let expected = Substring("pris@tine")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func dropPrefix5() {
        let example = Substring("1")
        let expected = Substring("1")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func dropPrefix6() {
        let example = Substring("")
        let expected = Substring("")

        #expect(example.dropPrefix("@") == expected)
    }

    @Test
    func dropSuffix1() {
        let example = Substring("***fu*bar***")
        let expected = Substring("***fu*bar")

        #expect(example.dropSuffix("*") == expected)
    }

    @Test
    func dropSuffix2() {
        let example = Substring("$goo$ber$")
        let expected = Substring("$goo$ber")

        #expect(example.dropSuffix("$") == expected)
    }

    @Test
    func dropSuffix3() {
        let example = Substring("###########")
        let expected = Substring("")

        #expect(example.dropSuffix("#") == expected)
    }

    @Test
    func dropSuffix4() {
        let example = Substring("pris@tine")
        let expected = Substring("pris@tine")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func dropSuffix5() {
        let example = Substring("1")
        let expected = Substring("1")

        #expect(example.dropSuffix("@") == expected)
    }

    @Test
    func dropSuffix6() {
        let example = Substring("")
        let expected = Substring("")

        #expect(example.dropSuffix("@") == expected)
    }
}
