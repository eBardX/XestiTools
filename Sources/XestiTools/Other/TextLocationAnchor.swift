// © 2025 John Gary Pusey (see LICENSE.md)

public struct TextLocationAnchor: CustomConsumingRegexComponent {

    // MARK: Public Nested Types

    public typealias RegexOutput = Substring

    // MARK: Public Initializers

    public init(line: UInt,
                column: UInt) {
        self.init(lines: line...line,
                  columns: column...column)
    }

    public init(line: UInt,
                columns: some RangeExpression<UInt> = 1...UInt.max) {
        self.init(lines: line...line,
                  columns: columns)
    }

    public init(lines: some RangeExpression<UInt> = 1...UInt.max,
                column: UInt) {
        self.init(lines: lines,
                  columns: column...column)
    }

    public init(lines: some RangeExpression<UInt> = 1...UInt.max,
                columns: some RangeExpression<UInt> = 1...UInt.max) {
        self.columns = columns
        self.lines = lines
    }

    // MARK: Public Instance Properties

    public let columns: any RangeExpression<UInt>
    public let lines: any RangeExpression<UInt>

    // MARK: Public Instance Methods

    public func consuming(_ input: String,
                          startingAt index: String.Index,
                          in bounds: Range<String.Index>) throws -> (upperBound: String.Index,
                                                                     output: Substring)? {
        guard let location = input.location(of: index),
              columns.contains(location.column),
              lines.contains(location.line)
        else { return nil }

        return (index, input[index..<index])
    }
}
