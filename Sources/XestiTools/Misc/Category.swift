// © 2023 J. G. Pusey (see LICENSE.md)

public struct Category: StringRepresentable {

    // MARK: Public Type Properties

    public static var invalidMessage = "category must not be empty"

    // MARK: Public Type Methods

    public static func isValid(_ stringValue: String) -> Bool {
        !stringValue.isEmpty
    }

    public init(_ stringValue: String) {
        precondition(Self.isValid(stringValue),
                     Self.invalidMessage)

        self.stringValue = stringValue
    }

    // MARK: Public Instance Properties

    public var stringValue: String
}
