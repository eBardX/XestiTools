// © 2025–2026 John Gary Pusey (see LICENSE.md)

import CoreGraphics
import Testing
@testable import XestiTools

struct JSONFormatterTests {
}

// MARK: -

extension JSONFormatterTests {
    @Test
    func test_formatNaNCGFloat() {
        let result = JSONFormatter.format(CGFloat.nan)

        #expect(result as? Int == 0)
    }

    @Test
    func test_formatNegativeInfinity() {
        let result = JSONFormatter.format(-CGFloat.infinity)

        #expect(result as? CGFloat == CGFloat.leastNormalMagnitude)
    }

    @Test
    func test_formatNilPoint() {
        let result = JSONFormatter.format(nil as CGPoint?)

        #expect(result == nil)
    }

    @Test
    func test_formatNilRect() {
        let result = JSONFormatter.format(nil as CGRect?)

        #expect(result == nil)
    }

    @Test
    func test_formatNilValue() {
        let result = JSONFormatter.format(nil as Any?)

        #expect(result == nil)
    }

    @Test
    func test_formatNonJSONSerializableValue() {
        let nonJSON = CGPoint(x: 1, y: 2)
        let result = JSONFormatter.format(nonJSON as Any?)

        #expect(result is String)
    }

    @Test
    func test_formatNormalCGFloat() {
        let result = JSONFormatter.format(CGFloat(3.14))

        #expect(result as? CGFloat == CGFloat(3.14))
    }

    @Test
    func test_formatPoint() {
        let result = JSONFormatter.format(CGPoint(x: 10, y: 20))

        #expect(result != nil)
        #expect(result?["x"] as? CGFloat == 10)
        #expect(result?["y"] as? CGFloat == 20)
    }

    @Test
    func test_formatPositiveInfinity() {
        let result = JSONFormatter.format(CGFloat.infinity)

        #expect(result as? CGFloat == CGFloat.greatestFiniteMagnitude)
    }

    @Test
    func test_formatRect() {
        let result = JSONFormatter.format(CGRect(x: 1, y: 2, width: 3, height: 4))

        #expect(result != nil)
        #expect(result?["x"] as? CGFloat == 1)
        #expect(result?["y"] as? CGFloat == 2)
        #expect(result?["width"] as? CGFloat == 3)
        #expect(result?["height"] as? CGFloat == 4)
    }

    @Test
    func test_formatString() {
        let result = JSONFormatter.format("hello" as Any?)

        #expect(result as? String == "hello")
    }

    @Test
    func test_formatValidJSONValue() {
        let result = JSONFormatter.format(42 as Any?)

        #expect(result as? Int == 42)
    }

    @Test
    func test_formatZeroCGFloat() {
        let result = JSONFormatter.format(CGFloat.zero)

        #expect(result as? CGFloat == 0)
    }
}
