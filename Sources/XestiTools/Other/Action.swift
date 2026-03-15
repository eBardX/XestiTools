// © 2020–2026 John Gary Pusey (see LICENSE.md)

/// A type encapsulating an action that can be synchronously performed.
public protocol Action {
    /// Performs the action synchronously.
    func perform() throws
}
