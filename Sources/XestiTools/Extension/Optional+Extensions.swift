// © 2018–2023 J. G. Pusey (see LICENSE.md)

extension Optional {
    public func require(hint: @autoclosure () -> String? = nil,
                        file: StaticString = #file,
                        line: UInt = #line) -> Wrapped {
        guard let unwrapped = self
        else { fatalError(hint() ?? "Missing required value",
                          file: file,
                          line: line) }

        return unwrapped
    }
}
