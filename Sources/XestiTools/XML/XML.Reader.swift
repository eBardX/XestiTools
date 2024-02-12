// © 2022–2024 John Gary Pusey (see LICENSE.md)

import Foundation

extension XML {
    public class Reader<E: Element, A: Attribute>: NSObject, XMLParserDelegate {

        // MARK: Private Initializers

        private init(parser: XMLParser) {
            self.parser = parser

            super.init()

            parser.delegate = self
            parser.shouldProcessNamespaces = true
        }

        // MARK: Private Instance Properties

        private let parser: XMLParser

        private var pendingChildren: [ReaderNode] = []
        private var pendingName: String = ""
        private var pendingText: String = ""
        private var pendingURI: String?
        private var result: ReaderNode?
        private var savedContexts: [(String, String?, [ReaderNode])] = []

        // MARK: Private Instance Methods

        private func _appendText(_ text: String) {
            pendingText += text
        }

        private func _endElement(_ name: String,
                                 _ uri: String?) {
            guard pendingName == name,
                  pendingURI == uri
            else { return }

            _flushText()

            let element: ReaderNode = .element(E(name, uri)!,
                                               pendingChildren)

            if let context = savedContexts.popLast() {
                (pendingName, pendingURI, pendingChildren) = context

                pendingChildren.append(element)
            } else {
                pendingChildren = []
                pendingName = name
                pendingURI = uri

                result = element
            }
        }

        private func _flushText() {
            let text = pendingText.normalizedXMLWhitespace()

            pendingText = ""

            guard !text.isEmpty
            else { return }

            pendingChildren.append(.text(text))
        }

        private func _startElement(_ name: String,
                                   _ uri: String?,
                                   _ attributes: [String: String]) {
            _flushText()

            if !pendingName.isEmpty {
                savedContexts.append((pendingName, pendingURI, pendingChildren))
            }

            pendingChildren = []
            pendingName = name
            pendingURI = uri

            for (name, value) in attributes {
                pendingChildren.append(.attribute(A(name)!, value))
            }
        }

        // MARK: XMLParserDelegate Instance Methods

        public func parser(_ parser: XMLParser,
                           didEndElement elementName: String,
                           namespaceURI: String?,
                           qualifiedName qName: String?) {
            _endElement(elementName,
                        namespaceURI)
        }

        public func parser(_ parser: XMLParser,
                           didStartElement elementName: String,
                           namespaceURI: String?,
                           qualifiedName qName: String?,
                           attributes attributeDict: [String: String]) {
            _startElement(elementName,
                          namespaceURI,
                          attributeDict)
        }

        public func parser(_ parser: XMLParser,
                           foundCDATA CDATABlock: Data) {
            guard
                let string = String(data: CDATABlock,
                                    encoding: .utf8)
            else { return }

            _appendText(string)
        }

        public func parser(_ parser: XMLParser,
                           foundCharacters string: String) {
            _appendText(string)
        }

        public func parser(_ parser: XMLParser,
                           foundIgnorableWhitespace whitespaceString: String) {
            // _appendText(whitespaceString)
        }

        // public func parserDidEndDocument(_ parser: XMLParser) {
        // }

        // public func parserDidStartDocument(_ parser: XMLParser) {
        // }
    }
}

// MARK: -

extension XML.Reader {

    // MARK: Public Nested Types

    public typealias ReaderNode = XML.Node<E, A>

    public typealias ReaderResult = Result<ReaderNode, XML.Error>

    // MARK: Public Initializers

    public convenience init?(contentsOf url: URL) {
        guard let parser = XMLParser(contentsOf: url)
        else { return nil }

        self.init(parser: parser)
    }

    public convenience init(data: Data) {
        self.init(parser: XMLParser(data: data))
    }

    public convenience init(stream: InputStream) {
        self.init(parser: XMLParser(stream: stream))
    }

    // MARK: Public Instance Methods

    public func read() -> ReaderResult {
        if parser.parse(),
           let result = result {
            return .success(result)
        } else {
            return .failure(.parseFailure(parser.parserError as (any EnhancedError)?))
        }
    }
}
