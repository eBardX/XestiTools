// © 2025 John Gary Pusey (see LICENSE.md)

extension Regex {

    // MARK: Public Instance Properties

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
