/// An unordered collection of ``Extra`` values, keyed by name.
///
/// An extras collection can be attached to any data structure that needs
/// heterogeneous, named metadata — associating arbitrary named tags or typed
/// values with an item without restricting callers to a single scalar type.
///
/// An extras collection stores a _single_ extra value per name.
public struct Extras {

    // MARK: Public Initializers

    /// Creates a new extras collection from an array of extra values.
    ///
    /// If the array contains extra values with duplicate names, only the last
    /// occurrence is inserted into the extras collection.
    ///
    /// - Parameter elements:   The array of ``Extra`` values to include in the
    ///                         new extras collection. Defaults to an empty
    ///                         array.
    public init(elements: [Extra] = []) {
        self.init(entries: Dictionary(uniqueKeysWithValues: elements.map { ($0.name, $0) }))
    }

    // MARK: Private Initializers

    private init(entries: [String: Extra]) {
        self.entries = entries
    }

    // MARK: Private Instance Properties

    private var entries: [String: Extra]
}

// MARK: -

extension Extras {

    // MARK: Public Instance Properties

    /// An array of the extra values in this extras collection, sorted by name.
    public var elements: [Extra] {
        var tmpElements: [Extra] = []

        for key in entries.keys.sorted() {
            if let entry = entries[key] {
                tmpElements.append(entry)
            }
        }

        return tmpElements
    }

    /// A Boolean value that indicates whether this extras collection is empty.
    public var isEmpty: Bool {
        entries.isEmpty
    }

    // MARK: Public Instance Methods

    /// Returns `true` if this extras collection contains an extra that
    /// _exactly_ matches the provided extra value (same name and same
    /// associated values).
    ///
    /// - Parameter extra:  The extra value to match.
    ///
    /// - Returns:  `true` if a match is found; otherwise, `false`.
    public func contains(_ extra: Extra) -> Bool {
        entries[extra.name] == extra
    }

    /// Inserts the provided extra value into this extras collection, replacing
    /// any existing extra value with the same name.
    ///
    /// - Parameter extra:  The extra value to insert.
    public mutating func insert(_ extra: Extra) {
        entries[extra.name] = extra
    }

    /// Creates and returns a new extras collection with the provided extra
    /// value inserted, replacing any existing extra value with the same name.
    ///
    /// - Parameter extra:  The extra value to insert.
    ///
    /// - Returns:  A new extras container containing `extra`.
    public func inserting(_ extra: Extra) -> Self {
        var new = self

        new.insert(extra)

        return new
    }

    /// Removes the provided extra value from this extras collection.
    ///
    /// This method does nothing if the extras collection does not contain an
    /// exact match (same name and same associated values) for the provided
    /// extra value.
    ///
    /// - Parameter extra:  The extra value to remove.
    public mutating func remove(_ extra: Extra) {
        guard contains(extra)
        else { return }

        entries[extra.name] = nil
    }

    /// Creates and returns a new extras collection with the provided extra
    /// value removed.
    ///
    /// This method returns `self` unchanged if the extras collection does not
    /// contain an exact match (same name and same associated values) for the
    /// provided extra value.
    ///
    /// - Parameter extra:  The extra value to remove.
    ///
    /// - Returns:  A new extras container without `extra`.
    public func removing(_ extra: Extra) -> Self {
        var new = self

        new.remove(extra)

        return new
    }
}

// MARK: - Codable

extension Extras: Codable {
}

// MARK: - Equatable

extension Extras: Equatable {
}

// MARK: - Sendable

extension Extras: Sendable {
}
