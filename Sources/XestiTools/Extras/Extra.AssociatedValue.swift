extension Extra {

    // MARK: Public Nested Types

    /// A typed scalar value that can be associated with an ``Extra`` value.
    ///
    /// An `AssociatedValue` wraps one of four primitive types — `Bool`,
    /// `Double`, `Int`, or `String` — so that an extra value can contain
    /// heterogeneous data in a single, codable array.
    public enum AssociatedValue {
        /// A Boolean value.
        case bool(Bool)

        /// A double-precision floating-point value.
        case double(Double)

        /// An integer value.
        case int(Int)

        /// A string value.
        case string(String)
    }
}

// MARK: - Codable

extension Extra.AssociatedValue: Codable {

    // MARK: Public Initializers

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let val = try? container.decode(Bool.self) {
            self = .bool(val)
        } else if let val = try? container.decode(Int.self) {
            self = .int(val)
        } else if let val = try? container.decode(Double.self) {
            self = .double(val)
        } else {
            self = .string(try container.decode(String.self))
        }
    }

    // MARK: Public Instance Methods

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case let .bool(val):
            try container.encode(val)

        case let .double(val):
            try container.encode(val)

        case let .int(val):
            try container.encode(val)

        case let .string(val):
            try container.encode(val)
        }
    }
}

// MARK: - Equatable

extension Extra.AssociatedValue: Equatable {
}

// MARK: - Hashable

extension Extra.AssociatedValue: Hashable {
}

// MARK: - Sendable

extension Extra.AssociatedValue: Sendable {
}
