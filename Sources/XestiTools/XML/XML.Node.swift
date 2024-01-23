// © 2022–2024 John Gary Pusey (see LICENSE.md)

extension XML {
    public enum Node {
        case attribute(String, String)
        case element(String, String?, [Self])
        case text(String)
    }
}

// MARK: -

extension XML.Node {

    // MARK: Public Instance Properties

    public var children: [XML.Node]? {
        switch self {
        case let .element(_, _, children):
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
        case let .attribute(name, _),
            let .element(name, _, _):
            return name

        default:
            return nil
        }
    }

    public var uri: String? {
        switch self {
        case let .element(_, uri, _):
            return uri

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

    public func allAttributes() -> [XML.Node] {
        children?.filter { $0.isAttribute } ?? []
    }

    public func allChildElements() -> [XML.Node] {
        children?.filter { $0.isElement } ?? []
    }

    public func allChildElements(_ name: String,
                                 _ uri: String? = nil) -> [XML.Node] {
        children?.filter { $0.isElement(name, uri) } ?? []
    }

    public func firstAttribute(_ name: String) -> XML.Node? {
        children?.first { $0.isAttribute(name) }
    }

    public func firstChildElement(_ name: String,
                                  _ uri: String? = nil) -> XML.Node? {
        children?.first { $0.isElement(name, uri) }
    }

    public func isAttribute(_ name: String) -> Bool {
        switch self {
        case let .attribute(aname, _):
            return aname == name

        default:
            return false
        }
    }

    public func isElement(_ name: String,
                          _ uri: String? = nil) -> Bool {
        switch self {
        case let .element(ename, euri, _):
            return ename == name && euri == uri

        default:
            return false
        }
    }

    public func valueOfAttribute(_ name: String,
                                 allowsEmpty: Bool = false) -> String? {
        guard let attribute = firstAttribute(name),
              let value = attribute.value,
              allowsEmpty || !value.isEmpty
        else { return nil }

        return value
    }

    public func valueOfChildElement(_ name: String,
                                    _ uri: String? = nil,
                                    allowsEmpty: Bool = false,
                                    recursive: Bool = false) -> String? {
        guard let element = firstChildElement(name, uri),
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
        case let .attribute(name, value):
            return "\(name)=\"\(value)\""

        case let .element(name, _, children):
            if children.isEmpty {
                return "<\(name)>"
            } else {
                return "<\(name)>\(children)"
            }

        case let .text(value):
            return "\"\(value)\""
        }
    }
}
