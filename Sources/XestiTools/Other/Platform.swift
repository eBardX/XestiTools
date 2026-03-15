// © 2020–2026 John Gary Pusey (see LICENSE.md)

/// A supported Swift platform.
public enum Platform: String {
    /// The Android platform.
    case android = "Android"

    /// The FreeBSD platform.
    case freeBSD = "FreeBSD"

    /// The iOS platform.
    case iOS

    /// The Linux platform.
    case linux = "Linux"

    /// The macOS platform.
    case macOS

    /// The OpenBSD platform.
    case openBSD = "OpenBSD"

    /// The tvOS platform.
    case tvOS

    /// The platform is unknown.
    case unknown

    /// The visionOS platform.
    case visionOS

    /// The WASI platform.
    case wasi = "WASI"

    /// The watchOS platform.
    case watchOS

    /// The Windows platform.
    case windows = "Windows"
}

// MARK: -

extension Platform {

    // MARK: Public Type Properties

    /// The current Swift platform.
    public static var current: Platform {
#if os(Android)
        return .android
#elseif os(FreeBSD)
        return .freeBSD
#elseif os(iOS)
        return .iOS
#elseif os(Linux)
        return .linux
#elseif os(macOS) || os(OSX)
        return .macOS
#elseif os(OpenBSD)
        return .openBSD
#elseif os(tvOS)
        return .tvOS
#elseif os(visionOS)
        return .visionOS
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

// MARK: - Sendable

extension Platform: Sendable {
}
