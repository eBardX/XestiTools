// © 2023–2026 John Gary Pusey (see LICENSE.md)

private import Foundation

/// An error with enhanced information.
public protocol EnhancedError: Error {
    /// The category to which this error belongs, or `nil` if this error belongs
    /// to no category. Defaults to `nil`.
    var category: Category? { get }

    /// The underlying error that caused this error to occur, or `nil` if this
    /// error has no underlying cause. Defaults to `nil`.
    var cause: (any EnhancedError)? { get }

    /// A dictionary representation of information contained in this message.
    var dictionaryRepresentation: [String: Any] { get }

    /// The human-readable description of this error.
    var message: String { get }
}

// MARK: - (defaults)

extension EnhancedError {
    public var category: Category? {
        nil
    }

    public var cause: (any EnhancedError)? {
        nil
    }

    public var dictionaryRepresentation: [String: Any] {
        var dict: [String: Any] = [:]

        dict["message"] = message

        if let strCategory = category?.stringValue {
            dict["category"] = strCategory
        } else {
            let error = self as NSError

            dict["code"] = error.code
            dict["domain"] = error.domain

            if let value = error.helpAnchor {
                dict["helpAnchor"] = value
            }

            if let value = error.localizedFailureReason {
                dict["reason"] = value
            }

            if let value = error.localizedRecoveryOptions {
                dict["recoveryOptions"] = value
            }

            if let value = error.localizedRecoverySuggestion {
                dict["recoverySuggestion"] = value
            }
        }

        if let causeDict = cause?.dictionaryRepresentation {
            dict["cause"] = causeDict
        }

        return dict
    }
}
