// © 2023–2026 John Gary Pusey (see LICENSE.md)

extension Result {

    // MARK: Public Initializers

    /// Creates a new result from the provided success and failure values.
    ///
    /// If both `success` and `failure` are non-`nil`, `failure` takes
    /// precedence.
    ///
    /// - Parameter success:    The success value, or `nil` if the new result
    ///                         does not represent success.
    /// - Parameter failure:    The failure value, or `nil` if the new result
    ///                         does not represent failure.
    /// - Parameter noResult:   A failure value representing “no result” if both
    ///                         `success` and `failure` are `nil`.
    public init(success: Success?,
                failure: Failure?,
                noResult: Failure) {
        if let failure {
            self = .failure(failure)
        } else if let success {
            self = .success(success)
        } else {
            self = .failure(noResult)
        }
    }

    // MARK: Public Instance Properties

    /// The failure value, or `nil` if this result represents a success.
    public var failure: Failure? {
        switch self {
        case let .failure(error):
            error

        case .success:
            nil
        }
    }

    /// The success value, or `nil` if this result represents a failure.
    public var success: Success? {
        switch self {
        case .failure:
            nil

        case let .success(value):
            value
        }
    }

    // MARK: Public Instance Methods

    /// Performs an action if this result represents a failure.
    ///
    /// - Parameter action: A closure that accepts a failure value as its
    ///                     argument.
    ///
    /// - Returns:  This result.
    @discardableResult
    public func onFailure(_ action: (Failure) -> Void) -> Result<Success, Failure> {
        switch self {
        case let .failure(error):
            action(error)

        case  .success:
            break
        }

        return self
    }

    /// Performs an action if this result represents a success.
    ///
    /// - Parameter action: A closure that accepts a success value as its
    ///                     argument.
    ///
    /// - Returns:  This result.
    @discardableResult
    public func onSuccess(_ action: (Success) -> Void) -> Result<Success, Failure> {
        switch self {
        case  .failure:
            break

        case let .success(value):
            action(value)
        }

        return self
    }
}
