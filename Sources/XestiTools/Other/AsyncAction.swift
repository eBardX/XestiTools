// © 2024–2026 John Gary Pusey (see LICENSE.md)

/// A type encapsulating an action that can be asynchronously performed.
public protocol AsyncAction {
    /// Performs the action asynchronously.
    func perform() async throws
}
