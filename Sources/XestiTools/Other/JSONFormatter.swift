// © 2023–2024 John Gary Pusey (see LICENSE.md)

import CoreGraphics
import Foundation

public enum JSONFormatter {

    // MARK: Public Type Methods

    public static func format(_ value: Any?) -> Any? {
        guard let value
        else { return nil }

        if JSONSerialization.isValidJSONObject([value]) {
            return value
        }

        return String(describing: value)
    }

    public static func format(_ value: CGFloat) -> Any {
        if value.isNaN {
            return 0
        }

        if value.isInfinite {
            return value.sign == .minus ? CGFloat.leastNormalMagnitude : CGFloat.greatestFiniteMagnitude
        }

        return value
    }

    public static func format(_ point: CGPoint?) -> [String: Any]? {
        guard let point
        else { return nil }

        return ["x": format(point.x),
                "y": format(point.y)]
    }

    public static func format(_ rect: CGRect?) -> [String: Any]? {
        guard let rect
        else { return nil }

        return ["x": format(rect.minX),
                "y": format(rect.minY),
                "width": format(rect.width),
                "height": format(rect.height)]
    }
}
