// © 2023 J. G. Pusey (see LICENSE.md)

import Foundation

public protocol EnhancedError: Error {
    var cause: (any EnhancedError)? { get }
    var message: String { get }
    var category: Category? { get }
}

// MARK: -

extension EnhancedError {
    public var dictionaryRepresentation: [String: Any] {
        var dict: [String: Any] = [:]

        dict["message"] = message

        if let strCategory = category?.stringValue {
            dict["category"] = strCategory
        } else {
            let error = self as NSError

            dict["code"] = error.code
            dict["domain"] = error.domain
            dict["helpAnchor"] = error.helpAnchor
            dict["reason"] = error.localizedFailureReason
            dict["recoveryOptions"] = error.localizedRecoveryOptions
            dict["recoverySuggestion"] = error.localizedRecoverySuggestion
        }

        dict["cause"] = cause?.dictionaryRepresentation

        return dict
    }
}

// MARK: -

extension NSError: EnhancedError {
    public var category: Category? {
        nil
    }

    public var cause: (any EnhancedError)? {
        userInfo[NSUnderlyingErrorKey] as? (any EnhancedError)
    }

    public var message: String {
        localizedDescription
    }
}
