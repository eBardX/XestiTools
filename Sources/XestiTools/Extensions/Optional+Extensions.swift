// © 2023–2024 John Gary Pusey (see LICENSE.md)

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

extension Optional where Wrapped: Equatable {
    public func nilIfEqual(to value: Wrapped) -> Wrapped? {
        guard let unwrapped = self,
              unwrapped != value
        else { return nil }

        return unwrapped
    }
}
