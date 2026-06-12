// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct UnsignedIntegerExtensionsTests {
}

// MARK: -

extension UnsignedIntegerExtensionsTests {
    @Test
    func gcd_UInt() {
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
    func gcd_UInt128() {
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
    func gcd_UInt16() {
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
    func gcd_UInt32() {
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
    func gcd_UInt64() {
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
    func gcd_UInt8() {
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

    @Test
    func isPowerOf2_UInt() {
        #expect(!UInt(0).isPowerOf2)
        #expect(UInt(1).isPowerOf2)
        #expect(UInt(2).isPowerOf2)
        #expect(!UInt(3).isPowerOf2)
        #expect(UInt(4).isPowerOf2)
        #expect(!UInt(5).isPowerOf2)
        #expect(!UInt(6).isPowerOf2)
        #expect(!UInt(7).isPowerOf2)
        #expect(UInt(8).isPowerOf2)
        #expect(!UInt(15).isPowerOf2)
        #expect(UInt(16).isPowerOf2)
        #expect(!UInt(255).isPowerOf2)
        #expect(UInt(256).isPowerOf2)
        #expect(!UInt(1_023).isPowerOf2)
        #expect(UInt(1_024).isPowerOf2)
        #expect(!UInt(1_000_000_000).isPowerOf2)
        #expect(UInt(1_073_741_824).isPowerOf2)
    }

    @Test
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, *)
    func isPowerOf2_UInt128() {
        #expect(!UInt128(0).isPowerOf2)
        #expect(UInt128(1).isPowerOf2)
        #expect(UInt128(2).isPowerOf2)
        #expect(!UInt128(3).isPowerOf2)
        #expect(UInt128(4).isPowerOf2)
        #expect(!UInt128(5).isPowerOf2)
        #expect(!UInt128(127).isPowerOf2)
        #expect(UInt128(128).isPowerOf2)
        #expect(!UInt128(255).isPowerOf2)
        #expect(UInt128(256).isPowerOf2)
        #expect(!UInt128(1_000_000_000_000_000_000_000).isPowerOf2)
        #expect((UInt128(1) << 100).isPowerOf2)
    }

    @Test
    func isPowerOf2_UInt16() {
        #expect(!UInt16(0).isPowerOf2)
        #expect(UInt16(1).isPowerOf2)
        #expect(UInt16(2).isPowerOf2)
        #expect(!UInt16(3).isPowerOf2)
        #expect(UInt16(4).isPowerOf2)
        #expect(!UInt16(5).isPowerOf2)
        #expect(!UInt16(127).isPowerOf2)
        #expect(UInt16(128).isPowerOf2)
        #expect(!UInt16(255).isPowerOf2)
        #expect(UInt16(256).isPowerOf2)
        #expect(!UInt16(32_767).isPowerOf2)
        #expect(UInt16(32_768).isPowerOf2)
        #expect(!UInt16(65_535).isPowerOf2)
    }

    @Test
    func isPowerOf2_UInt32() {
        #expect(!UInt32(0).isPowerOf2)
        #expect(UInt32(1).isPowerOf2)
        #expect(UInt32(2).isPowerOf2)
        #expect(!UInt32(3).isPowerOf2)
        #expect(UInt32(4).isPowerOf2)
        #expect(!UInt32(5).isPowerOf2)
        #expect(!UInt32(127).isPowerOf2)
        #expect(UInt32(128).isPowerOf2)
        #expect(!UInt32(255).isPowerOf2)
        #expect(UInt32(256).isPowerOf2)
        #expect(!UInt32(1_073_741_823).isPowerOf2)
        #expect(UInt32(1_073_741_824).isPowerOf2)
        #expect(!UInt32(2_147_483_647).isPowerOf2)
        #expect(UInt32(2_147_483_648).isPowerOf2)
        #expect(!UInt32(4_294_967_295).isPowerOf2)
    }

    @Test
    func isPowerOf2_UInt64() {
        #expect(!UInt64(0).isPowerOf2)
        #expect(UInt64(1).isPowerOf2)
        #expect(UInt64(2).isPowerOf2)
        #expect(!UInt64(3).isPowerOf2)
        #expect(UInt64(4).isPowerOf2)
        #expect(!UInt64(5).isPowerOf2)
        #expect(!UInt64(127).isPowerOf2)
        #expect(UInt64(128).isPowerOf2)
        #expect(!UInt64(255).isPowerOf2)
        #expect(UInt64(256).isPowerOf2)
        #expect(!UInt64(1_000_000_000_000_000_000).isPowerOf2)
        #expect(UInt64(4_611_686_018_427_387_904).isPowerOf2)
        #expect(!UInt64(9_223_372_036_854_775_807).isPowerOf2)
        #expect(UInt64(9_223_372_036_854_775_808).isPowerOf2)
        #expect(!UInt64.max.isPowerOf2)
    }

    @Test
    func isPowerOf2_UInt8() {
        #expect(!UInt8(0).isPowerOf2)
        #expect(UInt8(1).isPowerOf2)
        #expect(UInt8(2).isPowerOf2)
        #expect(!UInt8(3).isPowerOf2)
        #expect(UInt8(4).isPowerOf2)
        #expect(!UInt8(5).isPowerOf2)
        #expect(!UInt8(6).isPowerOf2)
        #expect(!UInt8(7).isPowerOf2)
        #expect(UInt8(8).isPowerOf2)
        #expect(UInt8(16).isPowerOf2)
        #expect(UInt8(32).isPowerOf2)
        #expect(UInt8(64).isPowerOf2)
        #expect(!UInt8(127).isPowerOf2)
        #expect(UInt8(128).isPowerOf2)
        #expect(!UInt8(255).isPowerOf2)
    }
}
