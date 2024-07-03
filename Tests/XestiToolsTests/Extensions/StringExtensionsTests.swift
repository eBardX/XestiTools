import XCTest
@testable import XestiTools

internal class StringExtensionsTests: XCTestCase {
}

// MARK: -

extension StringExtensionsTests {
    func test_matches() {
        XCTAssertFalse("aa".matches(pattern: "a"))
        XCTAssertTrue("aa".matches(pattern: "aa"))
        XCTAssertFalse("aaa".matches(pattern: "aa"))
        XCTAssertTrue("aa".matches(pattern: "*"))
        XCTAssertTrue("aa".matches(pattern: "a*"))
        XCTAssertTrue("ab".matches(pattern: "?*"))
        XCTAssertFalse("aab".matches(pattern: "c*a*b"))
    }

    func test_matches_ci1() {
        XCTAssertFalse("aa".matches(pattern: "A"))
        XCTAssertFalse("aa".matches(pattern: "Aa"))
        XCTAssertFalse("aaa".matches(pattern: "Aa"))
        XCTAssertTrue("aa".matches(pattern: "*"))
        XCTAssertFalse("aa".matches(pattern: "A*"))
        XCTAssertTrue("ab".matches(pattern: "?*"))
        XCTAssertFalse("aab".matches(pattern: "c*A*b"))
    }

    func test_matches_ci2() {
        XCTAssertFalse("aa".matches(pattern: "A",
                                    caseInsensitive: true))
        XCTAssertTrue("aa".matches(pattern: "Aa",
                                   caseInsensitive: true))
        XCTAssertFalse("aaa".matches(pattern: "Aa",
                                     caseInsensitive: true))
        XCTAssertTrue("aa".matches(pattern: "*",
                                   caseInsensitive: true))
        XCTAssertTrue("aa".matches(pattern: "A*",
                                   caseInsensitive: true))
        XCTAssertTrue("ab".matches(pattern: "?*",
                                   caseInsensitive: true))
        XCTAssertFalse("aab".matches(pattern: "c*A*b",
                                     caseInsensitive: true))
    }

    func test_matches_ci3() {
        XCTAssertFalse("Jon".matches(pattern: "jo?n",
                                     caseInsensitive: false))
        XCTAssertFalse("Jon".matches(pattern: "jo*n",
                                     caseInsensitive: false))
        XCTAssertFalse("Jon".matches(pattern: "jo?n",
                                     caseInsensitive: true))
        XCTAssertTrue("Jon".matches(pattern: "jo*n",
                                    caseInsensitive: true))

        XCTAssertFalse("John".matches(pattern: "jo?n",
                                      caseInsensitive: false))
        XCTAssertFalse("John".matches(pattern: "jo*n",
                                      caseInsensitive: false))
        XCTAssertTrue("John".matches(pattern: "jo?n",
                                     caseInsensitive: true))
        XCTAssertTrue("John".matches(pattern: "jo*n",
                                     caseInsensitive: true))

        XCTAssertFalse("Johnnie".matches(pattern: "jo?n?",
                                         caseInsensitive: false))
        XCTAssertFalse("Johnnie".matches(pattern: "jo?n*",
                                         caseInsensitive: false))
        XCTAssertFalse("Johnnie".matches(pattern: "jo?n?",
                                         caseInsensitive: true))
        XCTAssertTrue("Johnnie".matches(pattern: "jo?n*",
                                        caseInsensitive: true))

        XCTAssertFalse("Johnathan".matches(pattern: "jo?n",
                                           caseInsensitive: false))
        XCTAssertFalse("Johnathan".matches(pattern: "jo*n",
                                           caseInsensitive: false))
        XCTAssertFalse("Johnathan".matches(pattern: "jo?n",
                                           caseInsensitive: true))
        XCTAssertTrue("Johnathan".matches(pattern: "jo*n",
                                          caseInsensitive: true))

        XCTAssertFalse("Johnathan".matches(pattern: "Jo?n?",
                                           caseInsensitive: false))
        XCTAssertTrue("Johnathan".matches(pattern: "Jo?n*",
                                          caseInsensitive: false))
        XCTAssertFalse("Johnathan".matches(pattern: "Jo?n?",
                                           caseInsensitive: true))
        XCTAssertTrue("Johnathan".matches(pattern: "Jo?n*",
                                          caseInsensitive: true))
    }
}
