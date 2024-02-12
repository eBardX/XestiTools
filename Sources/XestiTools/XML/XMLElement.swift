// © 2024 John Gary Pusey (see LICENSE.md)

public protocol XMLElement: Equatable {
    init?(_ name: String,
          _ url: String?)

    var name: String { get }
    var uri: String? { get }
}
