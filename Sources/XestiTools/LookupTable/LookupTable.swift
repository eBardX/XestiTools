/// A lookup table that sorts its entries by key — preserving insertion order
/// when equal — and interpolates between the keys to produce a value for _any_
/// key.
///
/// Unlike a dictionary, a `LookupTable` instance does not require an exact key
/// match. Each entry is a (key, value) anchor, and ``subscript(_:)``
/// interpolates between the two entries that bracket a queried key. Every key
/// within range of the lookup table therefore yields a meaningful value, not
/// just the keys that were explicitly inserted.
///
/// Given a key, the lookup table:
///
/// 1. Finds the two entries that bracket the key.
/// 2. Computes the input fraction via
///    ``InterpolatableKey/fraction(from:through:)``.
/// 3. Maps the input fraction through ``Interpolator/checkedInterpolate(_:)``
///    to obtain the output fraction.
/// 4. Blends the values of the bracketing entries via
///    ``InterpolatableValue/value(of:from:through:)``.
///
/// Keys beyond the last entry return the value of the last entry; keys before
/// the first entry return the value of the first entry; an empty lookup table
/// returns ``defaultValue``.
///
/// Two entries may share the same key to model an *immediate* transition:
/// values approaching that key from below interpolate toward the value of the
/// first entry, while querying that key exactly snaps to the value of the
/// second entry.
///
/// The same ``interpolator`` is applied to every segment between adjacent
/// entries. Some examples of what a lookup table can model:
///
/// - *ADSR envelope* — entries keyed by time mark the boundaries of each
///   envelope stage (attack, decay, sustain, release); the interpolator
///   controls whether the transitions are linear, exponential, and so on.
/// - *Keyframe animation* — entries keyed by time anchor a property (position,
///   opacity, scale) at specific moments; all in-between frames are derived via
///   the interpolator.
/// - *Color gradient* — entries keyed by a scalar position (0–1) define color
///   stops; any position between stops yields a blended color.
///
/// Use ``subscript(_:)`` for lookups, and ``insert(key:value:extras:)``,
/// ``remove(key:value:extras:)``, and ``merge(with:)`` to mutate the lookup
/// table.
public struct LookupTable<Key, Value, Interp> where Key: InterpolatableKey,
                                                    Value: InterpolatableValue,
                                                    Interp: Interpolator {

    // MARK: Public Initializers

    /// Creates a new, empty lookup table with the provided default value and
    /// interpolator.
    ///
    /// - Parameter defaultValue:   The value to return when the lookup table is
    ///                             empty.
    /// - Parameter interpolator:   The interpolator to use when interpolating
    ///                             between entries in the lookup table.
    public init(defaultValue: Value,
                interpolator: Interp) {
        self.init(defaultValue: defaultValue,
                  interpolator: interpolator,
                  entries: [],
                  isSorted: true)
    }

    // MARK: Public Instance Properties

    /// The value to return when this lookup table is empty.
    public let defaultValue: Value

    /// The interpolator to use when interpolating between entries in this
    /// lookup table.
    public let interpolator: Interp

    /// A Boolean value that indicates whether at least one entry in this lookup
    /// table has an extras collection attached.
    ///
    /// This property enables you to efficiently determine whether metadata
    /// processing is required on this lookup table.
    public internal(set) var hasExtras: Bool

    // MARK: Internal Initializers

    internal init(defaultValue: Value,
                  interpolator: Interp,
                  entries: [Entry],
                  isSorted: Bool) {
        self.defaultValue = defaultValue
        self.entries = entries
        self.hasExtras = Self.determineHasExtras(entries)
        self.interpolator = interpolator

        if !isSorted {
            self.entries.sort()
        }
    }

    // MARK: Internal Instance Properties

    internal var entries: [Entry]
}

// MARK: - Codable

extension LookupTable: Codable {

    // MARK: Public Initializers

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        try self.init(defaultValue: container.decode(Value.self,
                                                     forKey: .defaultValue),
                      interpolator: container.decode(Interp.self,
                                                     forKey: .interpolator),
                      entries: container.decode([Entry].self,
                                                forKey: .entries),
                      isSorted: false)
    }

    // MARK: Public Instance Methods

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        //
        // Maintain order:
        //
        try container.encode(entries,
                             forKey: .entries)

        try container.encode(defaultValue,
                             forKey: .defaultValue)

        try container.encode(interpolator,
                             forKey: .interpolator)
    }

    // MARK: Private Nested Types

    private enum CodingKeys: String, CodingKey {
        case defaultValue
        case entries
        case interpolator
    }
}

// MARK: - Sendable

extension LookupTable: Sendable {
}
