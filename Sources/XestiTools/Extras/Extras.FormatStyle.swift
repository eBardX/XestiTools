public import Foundation

extension Extras {

    // MARK: Public Nested Types

    /// A format style that converts an extras collection to an attributed
    /// string.
    ///
    /// Instances of ``FormatStyle`` create localized, human-readable text from
    /// ``Extras`` collections.
    public struct FormatStyle {

        // MARK: Public Initializers

        /// Creates a format style that uses the provided locale.
        ///
        /// - Parameter locale: The locale to use when formatting extras
        ///                     collections. Defaults to `.autoupdatingCurrent`.
        public init(locale: Locale = .autoupdatingCurrent) {
            self.locale = locale
        }

        // MARK: Public Instance Properties

        /// The locale of the format style.
        ///
        /// Use the ``locale(_:)`` modifier to create a copy of this format
        /// style with a different locale.
        public private(set) var locale: Locale
    }
}

// MARK: - FormatStyle

extension Extras.FormatStyle: FormatStyle {

    // MARK: Public Instance Methods

    /// Formats the provided extras collection, using this style.
    ///
    /// - Parameter value:  The extras collection to format.
    ///
    /// - Returns:  An attributed string representation of the extras
    ///             collection, formatted according to this style.
    public func format(_ value: Extras) -> AttributedString {
        AttributedString(Self._combine(value.elements))
    }

    /// Modifies this format style to use the provided locale.
    ///
    /// Use this format style to change the locale used by an existing extras
    /// format style.
    ///
    /// - Parameter locale: The locale to apply to the format style.
    ///
    /// - Returns:  An extras format style modified to use the provided locale.
    public func locale(_ locale: Locale) -> Self {
        var new = self

        new.locale = locale

        return new
    }

    // MARK: Private Type Methods

    private static func _combine(_ elements: [Extra]) -> String {
        elements.map { $0.description }.joined(separator: ", ")
    }
}

// MARK: -

extension Extras {
    /// Formats this extras collection using the default localized format style.
    ///
    /// - Returns:  An attributed string representation of this extras
    ///             collection, formatted according to the default format style.
    public func formatted() -> AttributedString {
        FormatStyle().format(self)
    }
}
