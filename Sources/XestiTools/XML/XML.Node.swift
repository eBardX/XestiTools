// © 2022–2024 John Gary Pusey (see LICENSE.md)

extension XML {
    public enum Node<E: Element, A: Attribute> {
        case attribute(A, String)
        case element(E, [Self])
        case text(String)
    }
}

// MARK: -

extension XML.Node {

    // MARK: Public Instance Properties

    public var children: [Self]? {
        switch self {
        case let .element(_, children):
            return children

        default:
            return nil
        }
    }

    public var isAttribute: Bool {
        switch self {
        case .attribute:
            return true

        default:
            return false
        }
    }

    public var isElement: Bool {
        switch self {
        case .element:
            return true

        default:
            return false
        }
    }

    public var isText: Bool {
        switch self {
        case .text:
            return true

        default:
            return false
        }
    }

    public var name: String? {
        switch self {
        case let .attribute(attr, _):
            return attr.name

        case let .element(elem, _):
            return elem.name

        default:
            return nil
        }
    }

    public var uri: String? {
        switch self {
        case let .element(elem, _):
            return elem.uri

        default:
            return nil
        }
    }

    public var value: String? {
        switch self {
        case let .attribute(_, value),
            let .text(value):
            return value

        default:
            return nil
        }
    }

    // MARK: Public Instance Methods

    public func allAttributes() -> [Self] {
        children?.filter { $0.isAttribute } ?? []
    }

    public func allChildElements() -> [Self] {
        children?.filter { $0.isElement } ?? []
    }

    public func allChildElements(_ elem: E) -> [Self] {
        children?.filter { $0.isElement(elem) } ?? []
    }

    public func findNode(where predicate: (Self) throws -> Bool) rethrows -> Self? {
        if try predicate(self) {
            return self
        }

        guard let children
        else { return nil }

        for child in children {
            if let node = try child.findNode(where: predicate) {
                return node
            }
        }

        return nil
    }

    public func matches(_ elem: E,
                        _ attr: A,
                        _ value: String) -> Bool {
        isElement(elem) && valueOfAttribute(attr) == value
    }

    public func firstAttribute(_ attr: A) -> Self? {
        children?.first { $0.isAttribute(attr) }
    }

    public func firstChildElement(_ elem: E) -> Self? {
        children?.first { $0.isElement(elem) }
    }

    public func isAttribute(_ attr: A) -> Bool {
        switch self {
        case let .attribute(candAttr, _):
            return candAttr == attr

        default:
            return false
        }
    }

    public func isElement(_ elem: E) -> Bool {
        switch self {
        case let .element(candElem, _):
            return candElem == elem

        default:
            return false
        }
    }

    public func valueOfAttribute(_ name: A,
                                 allowsEmpty: Bool = false) -> String? {
        guard let attribute = firstAttribute(name),
              let value = attribute.value,
              allowsEmpty || !value.isEmpty
        else { return nil }

        return value
    }

    public func valueOfChildElement(_ elem: E,
                                    allowsEmpty: Bool = false,
                                    recursive: Bool = false) -> String? {
        guard let element = firstChildElement(elem),
              let value = element._valueOfElement(recursive),
              allowsEmpty || !value.isEmpty
        else { return nil }

        return value
    }

    public func valueOfElement(allowsEmpty: Bool = false,
                               recursive: Bool = false) -> String? {
        guard let value = _valueOfElement(recursive),
              allowsEmpty || !value.isEmpty
        else { return nil }

        return value
    }

    // MARK: Private Instance Methods

    private func _valueOfElement(_ recursive: Bool) -> String? {
        children?.reduce(into: "") { result, node in
            switch node {
            case .element:
                if recursive, let value = node._valueOfElement(recursive) {
                    result += value
                }

            case let .text(value):
                result += value

            default:
                break
            }
        }
    }
}

// MARK: - CustomStringConvertible

extension XML.Node: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .attribute(attr, value):
            return "\(attr.name)=\"\(value)\""

        case let .element(elem, children):
            if children.isEmpty {
                return "<\(elem.name)>"
            } else {
                return "<\(elem.name)>\(children)"
            }

        case let .text(value):
            return "\"\(value)\""
        }
    }
}
