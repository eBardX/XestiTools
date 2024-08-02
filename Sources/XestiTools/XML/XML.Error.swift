// © 2022–2024 John Gary Pusey (see LICENSE.md)

extension XML {
    public enum Error {
        case internalFailure
        case parseFailure((any EnhancedError)?, Int, Int)
        case unrecognizedAttribute(String, Int, Int)
        case unrecognizedElement(String, String?, Int, Int)
    }
}

// MARK: - EnhancedError

extension XML.Error: EnhancedError {
    public var cause: (any EnhancedError)? {
        switch self {
        case let .parseFailure(error, _, _):
            error

        default:
            nil
        }
    }

    public var message: String {
        switch self {
        case .internalFailure:
            "Internal failure"

        case let .parseFailure(_, line, column):
            "Unable to parse XML data, line: \(line), column: \(column)"

        case let .unrecognizedAttribute(name, line, column):
            "Unrecognized attribute name: \(name), line: \(line), column: \(column)"

        case let .unrecognizedElement(name, uri, line, column):
            if let uri, !uri.isEmpty {
                "Unrecognized element name: \(name), uri: \(uri), line: \(line), column: \(column)"
            } else {
                "Unrecognized element name: \(name), line: \(line), column: \(column)"
            }
        }
    }
}
