// © 2022–2024 John Gary Pusey (see LICENSE.md)

extension XML {
    public enum Error {
        case parseFailure((any EnhancedError)?)
    }
}

// MARK: - EnhancedError

extension XML.Error: EnhancedError {
    public var cause: (any EnhancedError)? {
        switch self {
        case let .parseFailure(error):
            return error
        }
    }

    public var message: String {
        switch self {
        case .parseFailure:
            return "Unable to parse XML data"
        }
    }
}
