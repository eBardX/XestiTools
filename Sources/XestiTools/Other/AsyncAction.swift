// © 2024–2026 John Gary Pusey (see LICENSE.md)

/// A type encapsulating an action that can be asynchronously performed.
public protocol AsyncAction {
    /// Performs the action asynchronously.
    ///
    /// - Throws:   An error if the action fails.
    func perform() async throws
}
