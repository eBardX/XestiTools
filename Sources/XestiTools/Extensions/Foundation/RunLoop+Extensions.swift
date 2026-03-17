// © 2023–2026 John Gary Pusey (see LICENSE.md)

import Foundation

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

    // MARK: Public Type Properties

    /// The default interval in seconds between action calls when waiting on a
    /// thread with its run loop.
    public static let defaultWaitInterval = TimeInterval(0.1)

    /// The default timeout in seconds when waiting on a thread with its run
    /// loop.
    public static let defaultWaitTimeout = TimeInterval(60)

    /// The default message to include in a timeout error.
    public static let defaultWaitMessage = "Timed out waiting"

    // MARK: Public Type Methods

    /// Waits on the current thread with its run loop for the specified number
    /// of seconds.
    ///
    /// - Parameter duration:   The number of seconds to wait.
    public static func wait(duration: TimeInterval) {
        current.run(until: Date(timeIntervalSinceNow: duration))
    }

    /// Waits on the current thread with its run loop until the provided action
    /// either succeeds or times out.
    ///
    /// An error is thrown if the wait times out before `action` succeeds.
    ///
    /// - Parameter action:     A closure that returns a Boolean value
    ///                         indicating whether the action has succeeded.
    /// - Parameter timeout:    The wait timeout in seconds. Defaults to
    ///                         ``defaultWaitTimeout``.
    /// - Parameter message:    The message to include in a timeout error.
    ///                         Defaults to ``defaultWaitMessage``.
    /// - Parameter interval:   The interval in seconds between action calls.
    ///                         Defaults to ``defaultWaitInterval``.
    public static func wait(until action: @autoclosure () -> Bool,
                            timeout: TimeInterval = defaultWaitTimeout,
                            message: String = defaultWaitMessage,
                            interval: TimeInterval = defaultWaitInterval) throws {
        try waitForValue(timeout: timeout,
                         message: message,
                         interval: interval) {
            action() ? true : nil
        }
    }

    /// Waits on the current thread with its run loop until the provided action
    /// either returns a non-`nil` value or times out.
    ///
    /// An error is thrown if the wait times out before `action` returns a
    /// non-`nil` value.
    ///
    /// - Parameter timeout:    The wait timeout in seconds. Defaults to
    ///                         ``defaultWaitTimeout``.
    /// - Parameter message:    The message to include in a timeout error.
    ///                         Defaults to ``defaultWaitMessage``.
    /// - Parameter interval:   The interval in seconds between action calls.
    ///                         Defaults to ``defaultWaitInterval``.
    /// - Parameter action:     A closure that returns `nil` if the action
    ///                         should be called again; otherwise, a non-`nil`
    ///                         value.
    ///
    /// - Returns:  The result of calling `action`.
    @discardableResult
    public static func waitForValue<T>(timeout: TimeInterval = defaultWaitTimeout,
                                       message: String = defaultWaitMessage,
                                       interval: TimeInterval = defaultWaitInterval,
                                       action: () throws -> T?) throws -> T {
        let timeoutDate = Date(timeIntervalSinceNow: timeout)
        let interval = min(interval, timeout)

        while true {
            if let result = try action() {
                return result
            }

            wait(duration: interval)

            if timeoutDate.timeIntervalSinceNow < 0 {
                throw Error.timedOut(message)
            }
        }
    }
}

// MARK: - EnhancedError

extension RunLoop.Error: EnhancedError {
    public var message: String {
        switch self {
        case let .timedOut(msg):
            return msg
        }
    }
}

// MARK: - Sendable

extension RunLoop.Error: Sendable {
}
