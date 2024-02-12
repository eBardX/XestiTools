// © 2024 John Gary Pusey (see LICENSE.md)

public protocol XMLAttribute: Equatable, Hashable {
    init?(_ name: String)

    var name: String { get }
}
