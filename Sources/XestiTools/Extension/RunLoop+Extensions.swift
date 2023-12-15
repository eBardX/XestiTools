// © 2023 J. G. Pusey (see LICENSE.md)

import Foundation

extension RunLoop {
    
    // MARK: Public Nested Types
    
    public enum Error {
        case timedOut(String)
    }
    
    // MARK: Public Type Properties
    
    public static let defaultWaitInterval = TimeInterval(0.1)
    public static let defaultWaitTimeout = TimeInterval(60)
    
    public static let defaultWaitMessage = "Timed out waiting"
    
    // MARK: Public Type Methods
    
    public static func wait(duration: TimeInterval) {
        current.run(until: Date(timeIntervalSinceNow: duration))
    }
    
    public static func wait(until action: @autoclosure () -> Bool,
                            timeout: TimeInterval = defaultWaitTimeout,
                            message: String = defaultWaitMessage) throws {
        try waitForValue(timeout: timeout,
                         message: message) {
            action() ? true : nil
        }
    }
    
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

// MARK: -

extension RunLoop.Error: EnhancedError {
    public var cause: (any EnhancedError)? {
        nil
    }
    
    public var message: String {
        switch self {
        case let .timedOut(msg):
            return msg
        }
    }
    
    public var category: Category? {
        nil
    }
}
