// © 2024–2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct StringExtensionsTests {
}

// MARK: -

extension StringExtensionsTests {
    @Test
    func location() {
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
    func matches() {
        #expect(!"aa".matches(pattern: "a"))
        #expect("aa".matches(pattern: "aa"))
        #expect(!"aaa".matches(pattern: "aa"))
        #expect("aa".matches(pattern: "*"))
        #expect("aa".matches(pattern: "a*"))
        #expect("ab".matches(pattern: "?*"))
        #expect(!"aab".matches(pattern: "c*a*b"))
    }

    @Test
    func matchesCI1() {
        #expect(!"aa".matches(pattern: "A"))
        #expect(!"aa".matches(pattern: "Aa"))
        #expect(!"aaa".matches(pattern: "Aa"))
        #expect("aa".matches(pattern: "*"))
        #expect(!"aa".matches(pattern: "A*"))
        #expect("ab".matches(pattern: "?*"))
        #expect(!"aab".matches(pattern: "c*A*b"))
    }

    @Test
    func matchesCI2() {
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
    func matchesCI3() {
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
}
