// © 2023—2024 John Gary Pusey (see LICENSE.md)

public struct AnyCodingKey: CodingKey {

    // MARK: Public Initializers

    public init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }

    public init?(stringValue: String) {
        self.intValue = nil
        self.stringValue = stringValue
    }

    public init<Key: CodingKey>(_ base: Key) {
        self.intValue = base.intValue
        self.stringValue = base.stringValue
    }

    // MARK: Public Instance Properties

    public let intValue: Int?
    public let stringValue: String
}

// MARK: - Equatable

extension AnyCodingKey: Equatable {
}

// MARK: - Hashable

extension AnyCodingKey: Hashable {
}
