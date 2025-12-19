// © 2025 John Gary Pusey (see LICENSE.md)

public struct TextLocation {

    // MARK: Public Initializers

    public init?(line: UInt,
                 column: UInt) {
        guard line > 0,
              column > 0
        else { return nil }

        self.init(line, column)
    }

    public init(_ line: UInt,
                _ column: UInt) {
        precondition(line > 0, "line must be greater than zero")
        precondition(column > 0, "column must be greater than zero")

        self.column = column
        self.line = line
    }

    // MARK: Public Instance Properties

    public let column: UInt
    public let line: UInt
}

// MARK: - Codable

extension TextLocation: Codable {
}

// MARK: - Equatable

extension TextLocation: Equatable {
}

// MARK: - Hashable

extension TextLocation: Hashable {
}
