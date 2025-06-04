// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public struct Condition: StringRepresentable {

        // MARK: Public Type Properties

        public static let initial = Self(stringValue: "",
                                         isInclusive: false,
                                         isInitial: true)

        // MARK: Public Initializers

        public init(_ stringValue: String) {
            self.init(stringValue: stringValue,
                      isInclusive: false,
                      isInitial: false)
        }

        public init(_ stringValue: String,
                    isInclusive: Bool) {
            self.init(stringValue: stringValue,
                      isInclusive: isInclusive,
                      isInitial: false)
        }

        // MARK: Public Instance Properties

        public let isInclusive: Bool
        public let isInitial: Bool
        public let stringValue: String

        // MARK: Private Initializers

        private init(stringValue: String,
                     isInclusive: Bool,
                     isInitial: Bool) {
            self.isInclusive = isInclusive
            self.isInitial = isInitial
            self.stringValue = isInitial ? stringValue : Self.requireValid(stringValue)
        }
    }
}

// MARK: - CustomStringConvertible

extension Tokenizer.Condition: CustomStringConvertible {
    public var description: String {
        if isInitial {
            "«INITIAL»"
        } else if isInclusive {
            "‹" + stringValue + "›+"
        } else {
            "‹" + stringValue + "›"
        }
    }
}
