/// A named annotation that can optionally be associated with an array of typed
/// scalar values.
///
/// An extra value is identified by its ``name`` and may contain an array of
/// zero or more associated ``values``. An extra value with no associated values
/// can act as a boolean flag or tag (for example, a “marker” or “special”
/// annotation). An extra value with associated values can act as act as a note
/// or an aside (for example, a “comment” annotation with a string value, or a
/// “priority” annotation with an integer value).
///
/// You can use an ``Extras`` collection to store a set of extra values and
/// attach them to any data structure that needs heterogeneous, named metadata.
public struct Extra {

    // MARK: Public Initializers

    /// Creates an extra value with the provided name and optional associated
    /// values.
    ///
    /// - Parameter name:   The name that identifies this extra value.
    /// - Parameter values: An optional array of associated values for the new
    ///                     extra value. Defaults to an empty array.
    public init(name: String,
                values: [AssociatedValue] = []) {
        self.name   = name
        self.values = values
    }

    // MARK: Public Instance Properties

    /// The name that identifies this extra value.
    public let name: String

    /// The optional array of associated values for this extra value.
    public let values: [AssociatedValue]
}

// MARK: - Codable

extension Extra: Codable {

    // MARK: Public Initializers

    public init(from decoder: any Decoder) throws {
        if var container = try? decoder.unkeyedContainer() {
            self.name = try container.decode(String.self)

            var tmpValues: [AssociatedValue] = []

            while !container.isAtEnd {
                tmpValues.append(try container.decode(AssociatedValue.self))
            }

            self.values = tmpValues
        } else {
            let container = try decoder.singleValueContainer()

            self.name = try container.decode(String.self)
            self.values = []
        }
    }

    // MARK: Public Instance Methods

    public func encode(to encoder: any Encoder) throws {
        if values.isEmpty {
            var container = encoder.singleValueContainer()

            try container.encode(name)
        } else {
            var container = encoder.unkeyedContainer()

            try container.encode(name)

            for value in values {
                try container.encode(value)
            }
        }
    }
}

// MARK: - CustomStringConvertible

extension Extra: CustomStringConvertible {
    public var description: String {
        if values.isEmpty {
            return name
        }

        let tmpStrings = values.map {
            switch $0 {
            case let .bool(val):
                return "\(val)"

            case let .double(val):
                return "\(val)"

            case let .int(val):
                return "\(val)"

            case let .string(val):
                return val
            }
        }

        return "\(name)(\(tmpStrings.joined(separator: ", ")))"
    }
}

// MARK: - Equatable

extension Extra: Equatable {
}

// MARK: - Hashable

extension Extra: Hashable {
}

// MARK: - Sendable

extension Extra: Sendable {
}
