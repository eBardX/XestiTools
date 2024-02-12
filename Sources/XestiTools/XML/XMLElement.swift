// © 2024 John Gary Pusey (see LICENSE.md)

public protocol XMLElement: Equatable {
    init?(_ name: String,
          _ url: String?)

    var name: String { get }
    var uri: String? { get }
}

// MARK: - (defaults)

extension XMLElement where Self: RawRepresentable,
                           Self.RawValue == String {

    // MARK: Internal Initializers

    internal init?(_ name: String,
                   _ url: String?) {
        guard url == nil
        else { return nil }

        self.init(rawValue: name)
    }

    // MARK: Internal Instance Properties

    internal var name: String {
        rawValue
    }

    internal var uri: String? {
        nil
    }
}
