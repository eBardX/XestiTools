// © 2023 J. G. Pusey (see LICENSE.md)

extension Array {
    public mutating func pop() -> Element? {
        guard !isEmpty
        else { return nil }

        return removeLast()
    }

    public mutating func push(_ elt: Element) {
        append(elt)
    }

    public func top() -> Element? {
        guard !isEmpty
        else { return nil }

        return last
    }
}
