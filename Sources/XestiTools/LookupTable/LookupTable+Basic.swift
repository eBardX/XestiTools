extension LookupTable {

    // MARK: Public Instance Properties

    /// A Boolean value that indicates whether this lookup table is empty.
    public var isEmpty: Bool {
        entries.isEmpty
    }

    // MARK: Public Instance Subscripts

    /// Calculates the interpolated value for the provided key:
    ///
    /// - If this lookup table is empty, the result is ``defaultValue``.
    /// - If the provided key is at or beyond the key of last entry in this
    ///   lookup table, the result is the value of the last entry.
    /// - If the provided key is before the key of the first entry in this
    ///   lookup table, the result is the value of the first entry.
    /// - Otherwise, the result is the value calculated by interpolating between
    ///   the two bracketing entries with ``interpolator``.
    ///
    /// - Parameter key:    The key to look up.
    ///
    /// - Returns:  The interpolated value.
    public subscript(_ key: Key) -> Value {
        guard !entries.isEmpty
        else { return defaultValue }

        guard let idx = entries.firstIndex(where: { key < $0.key })
        else { return entries[entries.endIndex - 1].value }

        guard idx > 0
        else { return entries[0].value }

        let startEntry = entries[idx - 1]
        let endEntry = entries[idx]

        let inFraction = key.fraction(from: startEntry.key,
                                      through: endEntry.key)
        let outFraction = interpolator.checkedInterpolate(inFraction)

        return Value.value(of: outFraction,
                           from: startEntry.value,
                           through: endEntry.value)
    }

    // MARK: Public Instance Methods

    /// Calls the provided closure on each entry in the lookup table in key
    /// order (or insertion order when keys are equal).
    ///
    /// - Parameter body:   A closure that takes the key, value, and optional
    ///                     extras collection of an entry of the lookup table as
    ///                     parameters.
    public func forEach(_ body: (Key, Value, Extras?) -> Void) {
        entries.forEach {
            body($0.key,
                 $0.value,
                 $0.extras)
        }
    }

    /// Inserts the provided key and value into this lookup table as a new
    /// entry, and optionally attaches an extras collection to it.
    ///
    /// If an entry with the same key already exists in the lookup table, the
    /// new entry is added immediately after the last entry with that key. Use
    /// ``remove(key:value:extras:)`` to remove a specific entry.
    ///
    /// - Parameter key:    The key for the entry to insert.
    /// - Parameter value:  The value for the entry to insert.
    /// - Parameter extras: The optional extras collection to attach to the
    ///                     entry.
    public mutating func insert(key: Key,
                                value: Value,
                                extras: Extras? = nil) {
        entries.insert(Entry(key: key,
                             value: value,
                             extras: extras),
                       at: indexForInserting(key: key,
                                             value: value,
                                             extras: extras))

        if extras != nil {
            hasExtras = true
        }
    }

    /// Creates and returns a new lookup table with the the provided key and
    /// value inserted as a new entry, and optionally attaches an extras
    /// collection to it.
    ///
    /// - Parameter key:    The key for the entry to insert.
    /// - Parameter value:  The value for the entry to insert.
    /// - Parameter extras: The optional extras collection to attach to the
    ///                     entry.
    ///
    /// - Returns:  A new lookup table containing the inserted entry.
    public func inserting(key: Key,
                          value: Value,
                          extras: Extras? = nil) -> Self {
        var new = self

        new.insert(key: key,
                   value: value,
                   extras: extras)

        return new
    }

    /// Merges all entries from the provided lookup table into this lookup
    /// table.
    ///
    /// If the provided lookup table is empty, this lookup table is unchanged.
    /// If this lookup table is empty, it is replaced by the provided lookup
    /// table. Otherwise, entries from both lookup tables are combined and
    /// re-sorted by key.
    ///
    /// - Parameter other:  The lookup table to merge into this lookup table.
    public mutating func merge(with other: Self) {
        guard !other.entries.isEmpty
        else { return }

        guard !entries.isEmpty
        else { self = other; return }

        entries.append(contentsOf: other.entries)
        entries.sort()

        hasExtras = hasExtras || other.hasExtras
    }

    /// Creates and returns a new lookup table containing all entries from the
    /// provided lookup table into this lookup table.
    ///
    /// - Parameter other:  The lookup table to merge into this lookup table.
    ///
    /// - Returns:  A new lookup table with the combined entries.
    public func merging(with other: Self) -> Self {
        var new = self

        new.merge(with: other)

        return new
    }

    /// Removes the first entry in this lookup table that exactly matches the
    /// provided key, value, and attached extras collection.
    ///
    /// This method does nothing if the lookup table does not contain an exact
    /// match for the provided key, value, and attached extras collection.
    ///
    /// - Parameter key:    The key of the entry to remove.
    /// - Parameter value:  The value of the entry to remove.
    /// - Parameter extras: The extras collection attached to the entry to
    ///                     remove.
    public mutating func remove(key: Key,
                                value: Value,
                                extras: Extras? = nil) {
        guard let index = indexMatching(key: key,
                                        value: value,
                                        extras: extras)
        else { return }

        entries.remove(at: index)

        if extras != nil {
            hasExtras = Self.determineHasExtras(entries)
        }
    }

    /// Creates and returns a new lookup table with the first entry in this
    /// lookup table that exactly matches the provided key, value, and attached
    /// extras collection, removed.
    ///
    /// This method returns `self` unchanged if the lookup table does not
    /// contain an exact match for the provided key, value, and attached extras
    /// collection.
    ///
    /// - Parameter key:    The key of the entry to remove.
    /// - Parameter value:  The value of the entry to remove.
    /// - Parameter extras: The extras collection attached to the entry to
    ///                     remove.
    ///
    /// - Returns: A new lookup table without the matching entry.
    public func removing(key: Key,
                         value: Value,
                         extras: Extras? = nil) -> Self {
        var new = self

        new.remove(key: key,
                   value: value,
                   extras: extras)

        return new
    }
}
