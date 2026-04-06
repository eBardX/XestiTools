// © 2024–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct StringExtensionsTests {
}

// MARK: -

extension StringExtensionsTests {
    @Test
    func test_escaped_preservesQuotesWhenUnprintableOnly() {
        let result = "it's \"quoted\" and \\slashed".escaped(asASCII: true,
                                                             unprintableOnly: true)

        #expect(result.contains("'"))
        #expect(result.contains("\""))
        #expect(result.contains("\\"))
    }

    @Test
    func test_escaped_specialChars() {
        let result = "a\tb\nc".escaped(asASCII: true,
                                       unprintableOnly: false)

        #expect(result.contains("\\t"))
        #expect(result.contains("\\n"))
    }

    @Test
    func test_escaped_unprintableOnly() {
        let result = "hello".escaped(asASCII: true,
                                     unprintableOnly: true)

        #expect(result == "hello")
    }

    @Test
    func test_location() {
        let value = "Every good boy deserves favor."
        let expectedLocationStart = TextLocation(1, 1)
        let expectedLocationEnd = TextLocation(1, UInt(value.count + 1))
        let actualLocationStart = value.location(of: value.startIndex)
        let actualLocationEnd = value.location(of: value.endIndex)

        #expect(actualLocationStart?.line == expectedLocationStart.line)
        #expect(actualLocationStart?.column == expectedLocationStart.column)
        #expect(actualLocationEnd?.line == expectedLocationEnd.line)
        #expect(actualLocationEnd?.column == expectedLocationEnd.column)
    }

    @Test
    func test_location_emoji() {
        let value = "🇺🇸abc"
        let idx = value.index(value.startIndex,
                              offsetBy: 1)
        let loc = value.location(of: idx)

        #expect(loc?.line == 1)
        #expect(loc?.column == 5)
    }

    @Test
    func test_location_middleOfLine() {
        let value = "abc\ndef\nghi"
        let idx = value.index(value.startIndex,
                              offsetBy: 5)
        let loc = value.location(of: idx)

        #expect(loc?.line == 2)
        #expect(loc?.column == 2)
    }

    @Test
    func test_location_multiLine() {
        let value = "line1\nline2\nline3"
        let idx = value.index(value.startIndex,
                              offsetBy: 6)
        let loc = value.location(of: idx)

        #expect(loc?.line == 2)
        #expect(loc?.column == 1)
    }

    @Test
    func test_matches() {
        #expect(!"aa".matches(pattern: "a"))
        #expect("aa".matches(pattern: "aa"))
        #expect(!"aaa".matches(pattern: "aa"))
        #expect("aa".matches(pattern: "*"))
        #expect("aa".matches(pattern: "a*"))
        #expect("ab".matches(pattern: "?*"))
        #expect(!"aab".matches(pattern: "c*a*b"))
    }

    @Test
    func test_matches_caseSensitive() {
        #expect(!"aa".matches(pattern: "A"))
        #expect(!"aa".matches(pattern: "Aa"))
        #expect(!"aaa".matches(pattern: "Aa"))
        #expect("aa".matches(pattern: "*"))
        #expect(!"aa".matches(pattern: "A*"))
        #expect("ab".matches(pattern: "?*"))
        #expect(!"aab".matches(pattern: "c*A*b"))
    }

    @Test
    func test_matches_caseInsensitive() {
        #expect(!"aa".matches(pattern: "A",
                              caseInsensitive: true))
        #expect("aa".matches(pattern: "Aa",
                             caseInsensitive: true))
        #expect(!"aaa".matches(pattern: "Aa",
                               caseInsensitive: true))
        #expect("aa".matches(pattern: "*",
                             caseInsensitive: true))
        #expect("aa".matches(pattern: "A*",
                             caseInsensitive: true))
        #expect("ab".matches(pattern: "?*",
                             caseInsensitive: true))
        #expect(!"aab".matches(pattern: "c*A*b",
                               caseInsensitive: true))
    }

    @Test
    func test_matches_caseInsensitiveNames() {
        #expect(!"Jon".matches(pattern: "jo?n",
                               caseInsensitive: false))
        #expect(!"Jon".matches(pattern: "jo*n",
                               caseInsensitive: false))
        #expect(!"Jon".matches(pattern: "jo?n",
                               caseInsensitive: true))
        #expect("Jon".matches(pattern: "jo*n",
                              caseInsensitive: true))

        #expect(!"John".matches(pattern: "jo?n",
                                caseInsensitive: false))
        #expect(!"John".matches(pattern: "jo*n",
                                caseInsensitive: false))
        #expect("John".matches(pattern: "jo?n",
                               caseInsensitive: true))
        #expect("John".matches(pattern: "jo*n",
                               caseInsensitive: true))

        #expect(!"Johnnie".matches(pattern: "jo?n?",
                                   caseInsensitive: false))
        #expect(!"Johnnie".matches(pattern: "jo?n*",
                                   caseInsensitive: false))
        #expect(!"Johnnie".matches(pattern: "jo?n?",
                                   caseInsensitive: true))
        #expect("Johnnie".matches(pattern: "jo?n*",
                                  caseInsensitive: true))

        #expect(!"Johnathan".matches(pattern: "jo?n",
                                     caseInsensitive: false))
        #expect(!"Johnathan".matches(pattern: "jo*n",
                                     caseInsensitive: false))
        #expect(!"Johnathan".matches(pattern: "jo?n",
                                     caseInsensitive: true))
        #expect("Johnathan".matches(pattern: "jo*n",
                                    caseInsensitive: true))

        #expect(!"Johnathan".matches(pattern: "Jo?n?",
                                     caseInsensitive: false))
        #expect("Johnathan".matches(pattern: "Jo?n*",
                                    caseInsensitive: false))
        #expect(!"Johnathan".matches(pattern: "Jo?n?",
                                     caseInsensitive: true))
        #expect("Johnathan".matches(pattern: "Jo?n*",
                                    caseInsensitive: true))
    }

    @Test
    func test_matches_emptyPatternAndString() {
        #expect("".matches(pattern: ""))
    }

    @Test
    func test_matches_questionMarkPattern() {
        #expect("a".matches(pattern: "?"))
        #expect(!"ab".matches(pattern: "?"))
        #expect(!"".matches(pattern: "?"))
    }

    @Test
    func test_matches_starOnlyPattern() {
        #expect("anything".matches(pattern: "*"))
        #expect("".matches(pattern: "*"))
    }

    @Test
    func test_nilIfEmpty_emptyString() {
        #expect("".nilIfEmpty == nil)
    }

    @Test
    func test_nilIfEmpty_nonEmptyString() {
        #expect("hello".nilIfEmpty == "hello")
    }

    @Test
    func test_nilIfEmpty_whitespace() {
        #expect(" ".nilIfEmpty == " ")
    }
}
