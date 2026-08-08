// © 2023–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension RunLoop {

    // MARK: Public Nested Types

    /// An error that occurs while waiting on a thread with its run loop.
    public enum Error {
        /// A run loop wait operation timed out.
        ///
        /// As an associated value, this case contains a string message
        /// describing the reason the operation timed out.
        case timedOut(String)
    }
}

// MARK: - EnhancedError

extension RunLoop.Error: EnhancedError {
    public var message: String {
        switch self {
        case let .timedOut(msg):
            msg
        }
    }
}

// MARK: - Sendable

extension RunLoop.Error: Sendable {
}
