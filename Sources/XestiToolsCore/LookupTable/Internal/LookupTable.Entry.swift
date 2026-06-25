extension LookupTable {

    // MARK: Internal Nested Types

    internal enum Entry {
        case custom(Key, Value, Extras)
        case simple(Key, Value)
    }
}

// MARK: -

extension LookupTable.Entry {

    // MARK: Internal Initializers

    internal init(key: Key,
                  value: Value,
                  extras: Extras?) {
        if let extras, !extras.isEmpty {
            self = .custom(key, value, extras)
        } else {
            self = .simple(key, value)
        }
    }

    // MARK: Internal Instance Properties

    internal var extras: Extras? {
        switch self {
        case let .custom(_, _, ext):
            ext

        default:
            nil
        }
    }

    internal var key: Key {
        switch self {
        case let .custom(key, _, _),
            let .simple(key, _):
            key
        }
    }

    internal var value: Value {
        switch self {
        case let .custom(_, val, _),
            let .simple(_, val):
            val
        }
    }
}

// MARK: - Codable

extension LookupTable.Entry: Codable {

    // MARK: Internal Initializers

    internal init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()

        let key = try container.decode(Key.self)
        let value = try container.decode(Value.self)
        let extras = try container.decodeIfPresent(Extras.self)

        if let extras {
            self = .custom(key, value, extras)
        } else {
            self = .simple(key, value)
        }
    }

    // MARK: Internal Instance Methods

    internal func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()

        try container.encode(key)
        try container.encode(value)

        if let extras {
            try container.encode(extras)
        }
    }
}

// MARK: - Comparable

extension LookupTable.Entry: Comparable {

    // MARK: Internal Type Methods

    internal static func < (lhs: Self,
                            rhs: Self) -> Bool {
        lhs.key < rhs.key
    }
}

// MARK: - Sendable

extension LookupTable.Entry: Sendable {
}
