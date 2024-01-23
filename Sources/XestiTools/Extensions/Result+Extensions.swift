// © 2023–2024 John Gary Pusey (see LICENSE.md)

extension Result {

    // MARK: Public Initializers

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

    public var failure: Failure? {
        switch self {
        case let .failure(error):
            return error

        case .success:
            return nil
        }
    }

    public var success: Success? {
        switch self {
        case .failure:
            return nil

        case let .success(value):
            return value
        }
    }

    // MARK: Public Instance Methods

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
