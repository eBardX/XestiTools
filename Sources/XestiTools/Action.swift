// © 2020–2022 J. G. Pusey (see LICENSE.md)

public protocol Action {
    associatedtype Value

    func perform() throws -> Value
}
