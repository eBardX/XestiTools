// © 2025 John Gary Pusey (see LICENSE.md)

extension Tokenizer {

    // MARK: Public Nested Types

    public struct Rule {

        // MARK: Public Initializers

        public init(_ regex: Regex<Substring>,
                    _ outKind: Token.Kind) {
            self.init(regex: regex,
                      disposition: .save(outKind, nil))
        }

        public init(regex: Regex<Substring>,
                    conditions: Set<Condition> = [.initial],
                    disposition: Disposition? = nil,
                    action: Action? = nil) {
            self.action = action ?? { _, _, _ in nil }
            self.conditions = conditions
            self.disposition = disposition
            self.regex = regex
            self.ruleID = RuleID()
        }

        // MARK: Public Instance Properties

        public let conditions: Set<Condition>
        public let regex: Regex<Substring>
        public let ruleID: RuleID

        // MARK: Internal Instance Properties

        internal let action: Action
        internal let disposition: Disposition?

        // MARK: Internal Instance Methods

        internal func isActive(for condition: Condition) -> Bool {
            if condition.isInclusive {
                conditions.contains(condition) || conditions.contains(.initial)
            } else {
                conditions.contains(condition)
            }
        }
    }
}

// MARK: - CustomStringConvertible

extension Tokenizer.Rule: CustomStringConvertible {
    public var description: String {
        "‹\(ruleID)›(\(_formatRegex(regex)), \(_formatConditions(conditions)), \(_formatDisposition(disposition)))"
    }
}

// MARK: - Equatable

extension Tokenizer.Rule: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.ruleID == rhs.ruleID
    }
}

// MARK: - Hashable

extension Tokenizer.Rule: Hashable {
    public func hash(into hasher: inout Hasher) {
        ruleID.hash(into: &hasher)
    }
}

// MARK: - Private Functions

private func _formatDisposition(_ disposition: Tokenizer.Disposition?) -> String {
    guard let disposition
    else { return "dynamic" }

    return disposition.description
}

private func _formatRegex(_ regex: Regex<Substring>) -> String {
    guard let pattern = regex.safeLiteralPattern
    else { return "unknown" }

    return "/" + liteEscape(pattern) + "/"
}

private func _formatConditions(_ conditions: Set<Tokenizer.Condition>) -> String {
    let items = conditions.map { $0.description }.sorted()

    return "[" + items.joined(separator: ",") + "]"
}
