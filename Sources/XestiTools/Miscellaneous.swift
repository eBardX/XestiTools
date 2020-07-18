// © 2018–2020 J. G. Pusey (see LICENSE.md)

import Foundation

public func clamp<T>(_ vmin: T,
                     _ value: T,
                     _ vmax: T) -> T where T: Comparable {
    return vmin > value ? vmin : vmax < value ? vmax : value
}

public func now() -> TimeInterval {
    return Date().timeIntervalSinceReferenceDate
}
