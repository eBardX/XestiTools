// © 2018–2022 J. G. Pusey (see LICENSE.md)

import Foundation

public func clamp<T>(_ vmin: T,
                     _ value: T,
                     _ vmax: T) -> T where T: Comparable {
    vmin > value ? vmin : vmax < value ? vmax : value
}

public func now() -> TimeInterval {
    Date().timeIntervalSinceReferenceDate
}
