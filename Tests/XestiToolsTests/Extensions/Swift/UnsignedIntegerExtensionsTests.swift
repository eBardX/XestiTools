// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct UnsignedIntegerExtensionsTests {
}

// MARK: -

extension UnsignedIntegerExtensionsTests {
    @Test
    func test_gcd_UInt() {
        #expect(UInt.gcd(12, 8) == 4)
        #expect(UInt.gcd(7, 5) == 1)
        #expect(UInt.gcd(0, 5) == 5)
        #expect(UInt.gcd(5, 0) == 5)
        #expect(UInt.gcd(0, 0) == 0)
        #expect(UInt.gcd(15, 15) == 15)
        #expect(UInt.gcd(100, 75) == 25)
        #expect(UInt.gcd(17, 13) == 1)
        #expect(UInt.gcd(10_000_000_000, 6_000_000_000) == 2_000_000_000)
    }

    @Test
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, *)
    func test_gcd_UInt128() {
        #expect(UInt128.gcd(12, 8) == 4)
        #expect(UInt128.gcd(7, 5) == 1)
        #expect(UInt128.gcd(0, 5) == 5)
        #expect(UInt128.gcd(5, 0) == 5)
        #expect(UInt128.gcd(0, 0) == 0)
        #expect(UInt128.gcd(15, 15) == 15)
        #expect(UInt128.gcd(100, 75) == 25)
        #expect(UInt128.gcd(17, 13) == 1)
        #expect(UInt128.gcd(1_000_000_000_000_000_000_000, 600_000_000_000_000_000_000) == 200_000_000_000_000_000_000)
    }

    @Test
    func test_gcd_UInt16() {
        #expect(UInt16.gcd(12, 8) == 4)
        #expect(UInt16.gcd(7, 5) == 1)
        #expect(UInt16.gcd(0, 5) == 5)
        #expect(UInt16.gcd(5, 0) == 5)
        #expect(UInt16.gcd(0, 0) == 0)
        #expect(UInt16.gcd(15, 15) == 15)
        #expect(UInt16.gcd(100, 75) == 25)
        #expect(UInt16.gcd(17, 13) == 1)
        #expect(UInt16.gcd(60_000, 45_000) == 15_000)
        #expect(UInt16.gcd(65_535, 21_845) == 21_845)
    }

    @Test
    func test_gcd_UInt32() {
        #expect(UInt32.gcd(12, 8) == 4)
        #expect(UInt32.gcd(7, 5) == 1)
        #expect(UInt32.gcd(0, 5) == 5)
        #expect(UInt32.gcd(5, 0) == 5)
        #expect(UInt32.gcd(0, 0) == 0)
        #expect(UInt32.gcd(15, 15) == 15)
        #expect(UInt32.gcd(100, 75) == 25)
        #expect(UInt32.gcd(17, 13) == 1)
        #expect(UInt32.gcd(3_000_000_000, 2_000_000_000) == 1_000_000_000)
    }

    @Test
    func test_gcd_UInt64() {
        #expect(UInt64.gcd(12, 8) == 4)
        #expect(UInt64.gcd(7, 5) == 1)
        #expect(UInt64.gcd(0, 5) == 5)
        #expect(UInt64.gcd(5, 0) == 5)
        #expect(UInt64.gcd(0, 0) == 0)
        #expect(UInt64.gcd(15, 15) == 15)
        #expect(UInt64.gcd(100, 75) == 25)
        #expect(UInt64.gcd(17, 13) == 1)
        #expect(UInt64.gcd(10_000_000_000_000_000_000, 6_000_000_000_000_000_000) == 2_000_000_000_000_000_000)
    }

    @Test
    func test_gcd_UInt8() {
        #expect(UInt8.gcd(12, 8) == 4)
        #expect(UInt8.gcd(7, 5) == 1)
        #expect(UInt8.gcd(0, 5) == 5)
        #expect(UInt8.gcd(5, 0) == 5)
        #expect(UInt8.gcd(0, 0) == 0)
        #expect(UInt8.gcd(15, 15) == 15)
        #expect(UInt8.gcd(100, 75) == 25)
        #expect(UInt8.gcd(17, 13) == 1)
        #expect(UInt8.gcd(240, 180) == 60)
        #expect(UInt8.gcd(255, 51) == 51)
    }
}
