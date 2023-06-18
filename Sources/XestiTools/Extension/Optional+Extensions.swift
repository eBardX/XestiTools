// © 2018–2022 J. G. Pusey (see LICENSE.md)

public extension Optional {
    func require(hint: @autoclosure () -> String? = nil,
                 file: StaticString = #file,
                 line: UInt = #line) -> Wrapped {
        guard let unwrapped = self
        else { fatalError(hint() ?? "Missing required value",
                          file: file,
                          line: line) }

        return unwrapped
    }
}
