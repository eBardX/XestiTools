extension LookupTable {

    // MARK: Internal Type Methods

    internal static func determineHasExtras(_ entries: [Entry]) -> Bool {
        entries.contains { $0.extras != nil }
    }

    // MARK: Internal Instance Methods

    internal func indexForInserting(key: Key,
                                    value: Value,
                                    extras: Extras?) -> Int {
        entries.firstIndex { key < $0.key } ?? entries.endIndex
    }

    internal func indexMatching(key: Key,
                                value: Value,
                                extras: Extras?) -> Int? {
        entries.firstIndex {
            (key, value, extras) == ($0.key, $0.value, $0.extras)
        }
    }
}
