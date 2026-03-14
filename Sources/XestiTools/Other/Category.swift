// © 2023–2026 John Gary Pusey (see LICENSE.md)

public struct Category: StringRepresentable {

    // MARK: Public Initializers

    public init?(stringValue: String) {
        guard Self.isValid(stringValue)
        else { return nil }

        self.stringValue = stringValue
    }

    // MARK: Public Instance Properties

    public let stringValue: String
}
