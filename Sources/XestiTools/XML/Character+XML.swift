// © 2022–2023 J. G. Pusey (see LICENSE.md)

extension Character {
    //
    // According to the XML 1.0 specification, whitespace consists of one or
    // more space (#x20), carriage return (#xD), line feed (#xA), or tab (#x9)
    // characters.
    //
    @available(*, deprecated, renamed: "isXMLWhitespace")
    public var isWhitespace: Bool {
        isXMLWhitespace
    }

    public var isXMLWhitespace: Bool {
        switch self {
        case "\n", "\r", "\t", " ":
            return true

        default:
            return false
        }
    }
}
