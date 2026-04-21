@testable import XestiTools

extension Extra {
    static let marker  = Extra(name: "marker")
    static let special = Extra(name: "special")

    static func comment(_ s: String) -> Extra {
        Extra(name: "comment", values: [.string(s)])
    }

    static func fubar(_ n: Int,
                      _ s: String) -> Extra {
        Extra(name: "fubar",
              values: [.int(n), .string(s)])
    }
}
