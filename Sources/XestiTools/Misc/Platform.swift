// © 2020–2024 John Gary Pusey (see LICENSE.md)

public enum Platform: String {
    case android = "Android"
    case cygwin  = "Cygwin"
    case freeBSD = "FreeBSD"
    case haiku   = "Haiku"
    case iOS
    case linux   = "Linux"
    case macOS
    case ps4     = "PS4"
    case tvOS
    case unknown
    case wasi    = "WASI"
    case watchOS
    case windows = "Windows"
}

// MARK: -

extension Platform {

    // MARK: Public Type Properties

    public static var current: Platform {
#if os(Android)
        return .android
#elseif os(Cygwin)
        return .cygwin
#elseif os(FreeBSD)
        return .freeBSD
#elseif os(Haiku)
        return .haiku
#elseif os(iOS)
        return .iOS
#elseif os(Linux)
        return .linux
#elseif os(macOS) || os(OSX)
        return .macOS
#elseif os(PS4)
        return .ps4
#elseif os(tvOS)
        return .tvOS
#elseif os(WASI)
        return .wasi
#elseif os(watchOS)
        return .watchOS
#elseif os(Windows)
        return .windows
#else
        return .unknown
#endif
    }
}
