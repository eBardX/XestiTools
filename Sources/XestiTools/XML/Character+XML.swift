// © 2022 J. G. Pusey (see LICENSE.md)

public extension Character {
    //
    // According to the XML 1.0 specification, whitespace consists of one or
    // more space (#x20), carriage return (#xD), line feed (#xA), or tab (#x9)
    // characters.
    //
    var isWhitespace: Bool {
        switch self {
        case " ",
            "\t",
            "\n",
            "\r":
            return true

        default:
            return false
        }
    }
}
