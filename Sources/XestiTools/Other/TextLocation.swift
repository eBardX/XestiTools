// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A location within a block of text expressed in terms of line and column
/// numbers.
public struct TextLocation {

    // MARK: Public Initializers

    /// Creates a new text location from the provided line and column numbers.
    ///
    /// If either `line` or `column` is zero, this initializer returns `nil`.
    /// 
    /// - Parameter line:   The line number in the text block.
    /// - Parameter column: The column number in the text block.
    public init?(line: UInt,
                 column: UInt) {
        guard line > 0,
              column > 0
        else { return nil }

        self.init(line, column)
    }

    /// Creates a new text location from the provided line and column numbers.
    ///
    /// If either `line` or `column` is zero, this initializer stops execution.
    ///
    /// - Parameter line:   The line number in the text block.
    /// - Parameter column: The column number in the text block.
    public init(_ line: UInt,
                _ column: UInt) {
        precondition(line > 0, "line must be greater than zero")
        precondition(column > 0, "column must be greater than zero")

        self.column = column
        self.line = line
    }

    // MARK: Public Instance Properties

    /// The column number in the text block.
    public let column: UInt

    /// The line number in the text block.
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

// MARK: - Sendable

extension TextLocation: Sendable {
}
