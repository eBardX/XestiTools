// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct SignedIntegerExtensionsTests {
}

// MARK: -

extension SignedIntegerExtensionsTests {
    @Test
    func test_modulo_Int() {
        #expect(7.modulo(3) == 1)
        #expect((-7).modulo(3) == 2)
        #expect(7.modulo(-3) == -2)
        #expect((-7).modulo(-3) == -1)
        #expect(0.modulo(3) == 0)
        #expect(6.modulo(3) == 0)
        #expect(1.modulo(1) == 0)
        #expect(10.modulo(7) == 3)
        #expect((-10).modulo(7) == 4)
        #expect(9_223_372_036_854_775_807.modulo(1_000_000_000) == 854_775_807)
        #expect(Int.min.modulo(1_000_000_000) == 145_224_192)
    }

    @Test
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, *)
    func test_modulo_Int128() {
        #expect(Int128(7).modulo(3) == 1)
        #expect(Int128(-7).modulo(3) == 2)
        #expect(Int128(7).modulo(-3) == -2)
        #expect(Int128(-7).modulo(-3) == -1)
        #expect(Int128(0).modulo(3) == 0)
        #expect(Int128(6).modulo(3) == 0)
        #expect(Int128(1).modulo(1) == 0)
        #expect(Int128(10).modulo(7) == 3)
        #expect(Int128(-10).modulo(7) == 4)
        #expect(Int128(1_000_000_000_000_000_000_000).modulo(7) == 6)
        #expect(Int128(-1_000_000_000_000_000_000_000).modulo(7) == 1)
    }

    @Test
    func test_modulo_Int16() {
        #expect(Int16(7).modulo(3) == 1)
        #expect(Int16(-7).modulo(3) == 2)
        #expect(Int16(7).modulo(-3) == -2)
        #expect(Int16(-7).modulo(-3) == -1)
        #expect(Int16(0).modulo(3) == 0)
        #expect(Int16(6).modulo(3) == 0)
        #expect(Int16(1).modulo(1) == 0)
        #expect(Int16(10).modulo(7) == 3)
        #expect(Int16(-10).modulo(7) == 4)
        #expect(Int16(32_767).modulo(1_000) == 767)
        #expect(Int16.min.modulo(1_000) == 232)
    }

    @Test
    func test_modulo_Int32() {
        #expect(Int32(7).modulo(3) == 1)
        #expect(Int32(-7).modulo(3) == 2)
        #expect(Int32(7).modulo(-3) == -2)
        #expect(Int32(-7).modulo(-3) == -1)
        #expect(Int32(0).modulo(3) == 0)
        #expect(Int32(6).modulo(3) == 0)
        #expect(Int32(1).modulo(1) == 0)
        #expect(Int32(10).modulo(7) == 3)
        #expect(Int32(-10).modulo(7) == 4)
        #expect(Int32(2_147_483_647).modulo(1_000_000) == 483_647)
        #expect(Int32.min.modulo(1_000_000) == 516_352)
    }

    @Test
    func test_modulo_Int64() {
        #expect(Int64(7).modulo(3) == 1)
        #expect(Int64(-7).modulo(3) == 2)
        #expect(Int64(7).modulo(-3) == -2)
        #expect(Int64(-7).modulo(-3) == -1)
        #expect(Int64(0).modulo(3) == 0)
        #expect(Int64(6).modulo(3) == 0)
        #expect(Int64(1).modulo(1) == 0)
        #expect(Int64(10).modulo(7) == 3)
        #expect(Int64(-10).modulo(7) == 4)
        #expect(Int64(9_223_372_036_854_775_807).modulo(1_000_000_000) == 854_775_807)
        #expect(Int64.min.modulo(1_000_000_000) == 145_224_192)
    }

    @Test
    func test_modulo_Int8() {
        #expect(Int8(7).modulo(3) == 1)
        #expect(Int8(-7).modulo(3) == 2)
        #expect(Int8(7).modulo(-3) == -2)
        #expect(Int8(-7).modulo(-3) == -1)
        #expect(Int8(0).modulo(3) == 0)
        #expect(Int8(6).modulo(3) == 0)
        #expect(Int8(1).modulo(1) == 0)
        #expect(Int8(10).modulo(7) == 3)
        #expect(Int8(-10).modulo(7) == 4)
        #expect(Int8(127).modulo(50) == 27)
        #expect(Int8.min.modulo(50) == 22)
    }
}
