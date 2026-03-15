// © 2023–2026 John Gary Pusey (see LICENSE.md)

import CoreGraphics
import Foundation

/// A namespace for type methods to facilitate formatting values into
/// JSON-compatible values.
public enum JSONFormatter {

    // MARK: Public Type Methods

    /// Formats the provided arbitrary value into a JSON-compatible object.
    ///
    /// - Parameter value:  The arbitrary value to format.
    ///
    /// - Returns:  The JSON-compatible value.
    public static func format(_ value: Any?) -> Any? {
        guard let value
        else { return nil }

        if JSONSerialization.isValidJSONObject([value]) {
            return value
        }

        return String(describing: value)
    }

    /// Formats the `CGFloat` value into a JSON-compatible number.
    ///
    /// - Parameter value:  The `CGFloat` value to format.
    ///
    /// - Returns:  The JSON-compatible number.
    public static func format(_ value: CGFloat) -> Any {
        if value.isNaN {
            return 0
        }

        if value.isInfinite {
            return value.sign == .minus ? CGFloat.leastNormalMagnitude : CGFloat.greatestFiniteMagnitude
        }

        return value
    }

    /// Formats the `CGPoint` value into a JSON-compatible dictionary.
    ///
    /// - Parameter point:  The `CGPoint` value to format.
    ///
    /// - Returns:  The JSON-compatible dictionary.
    public static func format(_ point: CGPoint?) -> [String: Any]? {
        guard let point
        else { return nil }

        return ["x": format(point.x),
                "y": format(point.y)]
    }

    /// Formats the `CGRect` value into a JSON-compatible dictionary.
    ///
    /// - Parameter rect:   The `CGRect` value to format.
    ///
    /// - Returns:  The JSON-compatible dictionary.
    public static func format(_ rect: CGRect?) -> [String: Any]? {
        guard let rect
        else { return nil }

        return ["x": format(rect.minX),
                "y": format(rect.minY),
                "width": format(rect.width),
                "height": format(rect.height)]
    }
}
