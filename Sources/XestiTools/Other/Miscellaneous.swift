// © 2018–2025 John Gary Pusey (see LICENSE.md)

import Foundation

public typealias Milliseconds = Int

public func clamp<T: Comparable>(_ vmin: T,
                                 _ value: T,
                                 _ vmax: T) -> T {
    vmin > value ? vmin : vmax < value ? vmax : value
}

public func liteEscape<S: StringProtocol>(_ value: S) -> String {
    String(value).escaped(asASCII: true,
                          unprintableOnly: true)
}

public func milliseconds(_ value: TimeInterval) -> Milliseconds {
    Milliseconds(value * 1_000)
}

public func now() -> TimeInterval {
    Date().timeIntervalSinceReferenceDate
}

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

public func timeInterval(_ value: Milliseconds) -> TimeInterval {
    TimeInterval(value) / TimeInterval(1_000)
}
