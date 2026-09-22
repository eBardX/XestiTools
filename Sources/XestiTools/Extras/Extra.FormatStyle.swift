// © 2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension Extra {

    // MARK: Public Nested Types

    /// A format style that converts an extra value to an attributed string.
    ///
    /// Instances of ``FormatStyle`` create localized, human-readable text from
    /// ``Extra`` values. Any numeric associated values are formatted using
    /// the style’s locale (for example, with locale-appropriate group
    /// separators).
    public struct FormatStyle {

        // MARK: Public Initializers

        /// Creates a format style that uses the provided locale.
        ///
        /// - Parameter locale: The locale to use when formatting extra
        ///                     values. Defaults to `.autoupdatingCurrent`.
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

extension Extra.FormatStyle: FormatStyle {

    // MARK: Public Instance Methods

    /// Formats the provided extra value, using this style.
    ///
    /// - Parameter value:  The extra value to format.
    ///
    /// - Returns:  An attributed string representation of the extra value,
    ///             formatted according to this style.
    public func format(_ value: Extra) -> AttributedString {
        AttributedString(Self._combine(value,
                                       locale))
    }

    /// Modifies this format style to use the provided locale.
    ///
    /// Use this format style to change the locale used by an existing extra
    /// format style.
    ///
    /// - Parameter locale: The locale to apply to the format style.
    ///
    /// - Returns:  An extra format style modified to use the provided locale.
    public func locale(_ locale: Locale) -> Self {
        var new = self

        new.locale = locale

        return new
    }

    // MARK: Private Type Methods

    private static func _combine(_ value: Extra,
                                 _ locale: Locale) -> String {
        if value.values.isEmpty {
            return value.name.description
        }

        let tmpStrings = value.values.map { _format($0, locale) }

        return "\(value.name)(\(tmpStrings.joined(separator: ", ")))"
    }

    private static func _format(_ value: Extra.AssociatedValue,
                                _ locale: Locale) -> String {
        switch value {
        case let .bool(val):
            "\(val)"

        case let .double(val):
            val.formatted(.number.locale(locale))

        case let .int(val):
            val.formatted(.number.locale(locale))

        case let .string(val):
            val
        }
    }
}

// MARK: -

extension Extra {
    /// Formats this extra value using the default localized format style.
    ///
    /// - Returns:  An attributed string representation of this extra value,
    ///             formatted according to the default format style.
    public func formatted() -> AttributedString {
        FormatStyle().format(self)
    }
}
