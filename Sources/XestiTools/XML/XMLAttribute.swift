// © 2024 John Gary Pusey (see LICENSE.md)

public protocol XMLAttribute: Equatable, Hashable {
    init?(_ name: String)

    var name: String { get }
}

// MARK: - (defaults)

extension XMLAttribute where Self: RawRepresentable,
                             Self.RawValue == String {

    // MARK: Internal Initializers

    internal init?(_ name: String) {
        self.init(rawValue: name)
    }

    // MARK: Internal Instance Properties

    internal var name: String {
        rawValue
    }
}
