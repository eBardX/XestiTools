// © 2025–2026 John Gary Pusey (see LICENSE.md)

import CoreGraphics
import Testing
@testable import XestiTools

struct JSONFormatterTests {
}

// MARK: -

extension JSONFormatterTests {
    @Test
    func format_nanCGFloat() {
        let result = JSONFormatter.format(CGFloat.nan)

        #expect(result as? Int == 0)
    }

    @Test
    func format_negativeInfinity() {
        let result = JSONFormatter.format(-CGFloat.infinity)

        #expect(result as? CGFloat == CGFloat.leastNormalMagnitude)
    }

    @Test
    func format_nilPoint() {
        let result = JSONFormatter.format(nil as CGPoint?)

        #expect(result == nil)
    }

    @Test
    func format_nilRect() {
        let result = JSONFormatter.format(nil as CGRect?)

        #expect(result == nil)
    }

    @Test
    func format_nilValue() {
        let result = JSONFormatter.format(nil as Any?)

        #expect(result == nil)
    }

    @Test
    func format_nonJSONSerializableValue() {
        let nonJSON = CGPoint(x: 1, y: 2)
        let result = JSONFormatter.format(nonJSON as Any?)

        #expect(result is String)
    }

    @Test
    func format_normalCGFloat() {
        let result = JSONFormatter.format(CGFloat(3.14))

        #expect(result as? CGFloat == CGFloat(3.14))
    }

    @Test
    func format_point() {
        let result = JSONFormatter.format(CGPoint(x: 10, y: 20))

        #expect(result != nil)
        #expect(result?["x"] as? CGFloat == 10)
        #expect(result?["y"] as? CGFloat == 20)
    }

    @Test
    func format_positiveInfinity() {
        let result = JSONFormatter.format(CGFloat.infinity)

        #expect(result as? CGFloat == CGFloat.greatestFiniteMagnitude)
    }

    @Test
    func format_rect() {
        let result = JSONFormatter.format(CGRect(x: 1, y: 2, width: 3, height: 4))

        #expect(result != nil)
        #expect(result?["x"] as? CGFloat == 1)
        #expect(result?["y"] as? CGFloat == 2)
        #expect(result?["width"] as? CGFloat == 3)
        #expect(result?["height"] as? CGFloat == 4)
    }

    @Test
    func format_string() {
        let result = JSONFormatter.format("hello" as Any?)

        #expect(result as? String == "hello")
    }

    @Test
    func format_validJSONValue() {
        let result = JSONFormatter.format(42 as Any?)

        #expect(result as? Int == 42)
    }

    @Test
    func format_zeroCGFloat() {
        let result = JSONFormatter.format(CGFloat.zero)

        #expect(result as? CGFloat == 0)
    }
}
