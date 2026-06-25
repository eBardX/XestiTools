// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Regex {

    // MARK: Public Instance Properties

    /// The literal pattern of this regular expression, if available; otherwise,
    /// `nil`.
    public var safeLiteralPattern: String? {
#if compiler(>=6)
    #if os(iOS)
        if #available(iOS 18.0, *) {
            _literalPattern
        } else {
            nil
        }
    #elseif os(macOS)
        if #available(macOS 15.0, *) {
            _literalPattern
        } else {
            nil
        }
    #else
        nil
    #endif
#else
        nil
#endif
    }
}
