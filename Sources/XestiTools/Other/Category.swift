// © 2023–2026 John Gary Pusey (see LICENSE.md)

/// A logging or tracing category.
public struct Category: StringRepresentable {

    // MARK: Public Initializers

    /// Creates a new category with the provided string value.
    ///
    /// If the provided string value is empty, this initializer
    /// returns `nil`.
    ///
    /// - Parameter stringValue:    The string value to use for the new
    ///                             category.
    public init?(stringValue: String) {
        guard Self.isValid(stringValue)
        else { return nil }

        self.stringValue = stringValue
    }

    // MARK: Public Instance Properties

    /// The string value that represents this category.
    ///
    /// A new category instance initialized with `stringValue` will be
    /// equivalent to this instance.
    public let stringValue: String
}
