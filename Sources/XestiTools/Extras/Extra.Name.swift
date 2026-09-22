// © 2026 John Gary Pusey (see LICENSE.md)

extension Extra {

    // MARK: Public Nested Types

    /// The name that identifies an ``Extra`` value.
    public struct Name {

        // MARK: Public Initializers

        /// Creates a new name with the provided string value.
        ///
        /// If the provided string value is empty, this initializer
        /// returns `nil`.
        ///
        /// - Parameter stringValue:    The string value to use for the new
        ///                             name.
        public init?(stringValue: String) {
            guard Self.isValid(stringValue)
            else { return nil }

            self.stringValue = stringValue
        }

        // MARK: Public Instance Properties

        /// The string value that represents this name.
        ///
        /// A new name instance initialized with `stringValue` will be
        /// equivalent to this instance.
        public let stringValue: String
    }
}

// MARK: -

extension Extra.Name {

    // MARK: Public Type Methods

    /// Determines if the provided string value is a valid representation
    /// for this type.
    ///
    /// A valid name begins with an ASCII letter, followed by zero or more
    /// ASCII letters or digits.
    ///
    /// - Parameter stringValue:    The string value to check for validity.
    ///
    /// - Returns:  `true` if the provided string value is a valid
    ///             representation for this type; `false` otherwise.
    public static func isValid(_ stringValue: String) -> Bool {
        guard let first = stringValue.first,
              first.isASCII,
              first.isLetter
        else { return false }

        return stringValue.dropFirst().allSatisfy {
            $0.isASCII && ($0.isLetter || $0.isNumber)
        }
    }
}

// MARK: - StringRepresentable

extension Extra.Name: StringRepresentable {
}
