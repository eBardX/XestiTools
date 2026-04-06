// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct VerbosityTests {
}

// MARK: -

extension VerbosityTests {
    @Test
    func test_comparable() {
        #expect(Verbosity.silent < .quiet)
        #expect(Verbosity.quiet < .verbose)
        #expect(Verbosity.verbose < .veryVerbose)
    }

    @Test
    func test_comparable_notLessThanSelf() {
        #expect(!(Verbosity.silent < .silent))
        #expect(!(Verbosity.veryVerbose < .veryVerbose))
    }

    @Test
    func test_comparable_reverse() {
        #expect(!(Verbosity.quiet < .silent))
        #expect(!(Verbosity.veryVerbose < .verbose))
    }

    @Test
    func test_equatable() {
        #expect(Verbosity.silent == .silent)
        #expect(Verbosity.quiet == .quiet)
        #expect(Verbosity.verbose == .verbose)
        #expect(Verbosity.veryVerbose == .veryVerbose)
    }

    @Test
    func test_init_fromRawValue() {
        #expect(Verbosity(rawValue: 0) == .silent)
        #expect(Verbosity(rawValue: 1) == .quiet)
        #expect(Verbosity(rawValue: 2) == .verbose)
        #expect(Verbosity(rawValue: 3) == .veryVerbose)
        #expect(Verbosity(rawValue: 4) == nil)
        #expect(Verbosity(rawValue: -1) == nil)
    }

    @Test
    func test_notEqual() {
        #expect(Verbosity.silent != .quiet)
        #expect(Verbosity.quiet != .verbose)
    }

    @Test
    func test_rawValues() {
        #expect(Verbosity.silent.rawValue == 0)
        #expect(Verbosity.quiet.rawValue == 1)
        #expect(Verbosity.verbose.rawValue == 2)
        #expect(Verbosity.veryVerbose.rawValue == 3)
    }
}
