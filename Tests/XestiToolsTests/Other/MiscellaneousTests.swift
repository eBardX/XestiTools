// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiTools

struct MiscellaneousTests {
}

// MARK: -

extension MiscellaneousTests {
    @Test
    func clamp_doubles() {
        let r1: Double = clamp(1.0, 0.5, 2.0)
        let r2: Double = clamp(1.0, 3.0, 2.0)
        let r3: Double = clamp(1.0, 0.1, 2.0)

        #expect(r1 == 1.0)
        #expect(r2 == 2.0)
        #expect(r3 == 1.0)
    }

    @Test
    func clamp_strings() {
        #expect(clamp("b", "a", "d") == "b")
        #expect(clamp("b", "e", "d") == "d")
        #expect(clamp("b", "a", "d") == "b")
    }

    @Test
    func clamp_valueAboveMaximum() {
        #expect(clamp(0, 15, 10) == 10)
    }

    @Test
    func clamp_valueAtMaximum() {
        #expect(clamp(0, 10, 10) == 10)
    }

    @Test
    func clamp_valueAtMinimum() {
        #expect(clamp(0, 0, 10) == 0)
    }

    @Test
    func clamp_valueBelowMinimum() {
        #expect(clamp(0, -5, 10) == 0)
    }

    @Test
    func clamp_valueWithinRange() {
        #expect(clamp(0, 5, 10) == 5)
    }

    @Test
    func milliseconds() {
        #expect(XestiTools.milliseconds(1.0) == 1_000)
        #expect(XestiTools.milliseconds(0.5) == 500)
        #expect(XestiTools.milliseconds(0.001) == 1)
        #expect(XestiTools.milliseconds(0.0) == 0)
    }

    @Test
    func milliseconds_roundTrip() {
        let ms: Milliseconds = 1_500
        let ti = XestiTools.timeInterval(ms)
        let backToMs = XestiTools.milliseconds(ti)

        #expect(backToMs == ms)
    }

    @Test
    func now_returnsPositiveValue() {
        let timestamp = now()

        #expect(timestamp > 0)
    }

    @Test
    func stringify_array() {
        let result = stringify([1, 2, 3])

        #expect(result == "[1,2,3]")
    }

    @Test
    func stringify_bool() {
        #expect(stringify(true) == "true")
        #expect(stringify(false) == "false")
    }

    @Test
    func stringify_dictionary() {
        let result = stringify(["key": "value"])

        #expect(result.contains("key"))
        #expect(result.contains("value"))
    }

    @Test
    func stringify_double() {
        let result = stringify(3.14)

        #expect(result.contains("3.14"))
    }

    @Test
    func stringify_integer() {
        #expect(stringify(42) == "42")
    }

    @Test
    func stringify_string() {
        #expect(stringify("hello") == "\"hello\"")
    }

    @Test
    func timeInterval() {
        let t1 = XestiTools.timeInterval(1_000)
        let t2 = XestiTools.timeInterval(500)
        let t3 = XestiTools.timeInterval(1)
        let t4 = XestiTools.timeInterval(0)

        #expect(t1 == 1.0)
        #expect(t2 == 0.5)
        #expect(t3 == 0.001)
        #expect(t4 == 0.0)
    }
}
