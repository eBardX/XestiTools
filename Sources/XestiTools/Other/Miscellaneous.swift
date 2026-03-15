// © 2018–2026 John Gary Pusey (see LICENSE.md)

import Foundation

/// A number of milliseconds.
///
/// Fractions of milliseconds are not supported.
public typealias Milliseconds = Int

/// Returns the given value to the specified range.
///
/// - Parameter vmin:  The minimum value allowed.
/// - Parameter value: The value to clamp.
/// - Parameter vmax:  The maximum value allowed.
///
/// - Returns: The clamped value.
public func clamp<T: Comparable>(_ vmin: T,
                                 _ value: T,
                                 _ vmax: T) -> T {
    vmin > value ? vmin : vmax < value ? vmax : value
}

/// Returns a “litely” escaped copy of the given string.
///
/// - Returns: The escaped string.
public func liteEscape<S: StringProtocol>(_ value: S) -> String {
    String(value).escaped(asASCII: true,
                          unprintableOnly: true)
}

/// Converts the given time interval to milliseconds.
///
/// - Parameter value: The time interval to convert.
///
/// - Returns: The converted value.
public func milliseconds(_ value: TimeInterval) -> Milliseconds {
    Milliseconds(value * 1_000)
}

/// Returns the time interval between now and the systems’s absolute
/// reference date.
///
/// - Returns: The current time as a time interval.
public func now() -> TimeInterval {
    Date().timeIntervalSinceReferenceDate
}

/// Converts the given value to a string.
///
/// This function attempts to convert the given value into a JSON
/// representation. If that fails, it falls back to calling
/// `String(describing:)` on the given value.
///
/// - Parameter value: The value to convert.
///
/// - Returns: The converted value.
public func stringify(_ value: Any) -> String {
    switch value {
    case is [Any], is [String: Any]:
        guard let data = try? JSONSerialization.data(withJSONObject: value),
              let string = String(data: data,
                                  encoding: .utf8)
        else { return String(describing: value) }

        return string

    default:
        guard let data = try? JSONSerialization.data(withJSONObject: [value]),
              let string = String(data: data,
                                  encoding: .utf8),
              string.hasPrefix("["),
              string.hasSuffix("]")
        else { return String(describing: value) }

        return String(string.dropFirst().dropLast())
    }
}

/// Converts the given number of milliseconds to the equivalent time interval.
///
/// - Parameter value: The number of milliseconds to convert.
///
/// - Returns: The converted value.
public func timeInterval(_ value: Milliseconds) -> TimeInterval {
    TimeInterval(value) / TimeInterval(1_000)
}
