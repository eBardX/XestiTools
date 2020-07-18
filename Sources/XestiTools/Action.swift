// © 2020 J. G. Pusey (see LICENSE.md)

public protocol Action {
    associatedtype Value

    func perform() throws -> Value
}
